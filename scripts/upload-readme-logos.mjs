#!/usr/bin/env node
/**
 * Verify, upload, and catalog broken operator README logos on Pinata.
 * Reads PINATA_JWT / PINATA_GATEWAY from O1/.env (or env vars).
 */
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const REPO_ROOT = path.resolve(__dirname, "..");
const O1_ENV = path.resolve(REPO_ROOT, "../../O1/.env");
const MANIFEST_PATH = path.join(REPO_ROOT, "public/logos/pinata-manifest.json");
const PROJECT = "operator-readme-logos";

function loadEnvFile(filePath) {
  if (!fs.existsSync(filePath)) return {};
  const out = {};
  for (const line of fs.readFileSync(filePath, "utf8").split("\n")) {
    const m = line.match(/^([A-Z0-9_]+)=(.*)$/);
    if (m) out[m[1]] = m[2];
  }
  return out;
}

const env = { ...loadEnvFile(O1_ENV), ...process.env };
const JWT = env.PINATA_JWT;
const GATEWAY = (env.PINATA_GATEWAY || "https://aqua-characteristic-rabbit-42.mypinata.cloud").replace(/\/$/, "");

if (!JWT) {
  console.error("PINATA_JWT not found in O1/.env or environment");
  process.exit(1);
}

/** Reuse verified O1 splash Pinata CIDs */
const REUSE = {
  chainlink: {
    cid: "bafkreif3avobjtbmuqrodshyjfjnxskmcmixkltuzc3qeckzy4tjaz66ki",
    source: "reuse:o1-splash",
  },
  geth: {
    cid: "QmQKan5FXqoR5tB5X9aD58FJWwwJAkMjxWEKZWG6pTTf6R",
    source: "reuse:o1-splash-ethereum",
  },
  base: {
    cid: "bafkreicqiem7vzadyvfqmnxxobmr3nrp762a7kuwirngntzr6xzzddsnyu",
    source: "reuse:o1-splash-docker",
  },
};

/** Logos to fetch and upload */
const UPLOADS = [
  {
    id: "litecoin",
    file: "litecoin.jpg",
    local: "public/logos/litecoin.jpg",
    url: null,
  },
  {
    id: "lodestar",
    file: "lodestar.png",
    local: "public/logos/lodestar.png",
    url: null,
  },
  {
    id: "mina",
    file: "mina.png",
    local: "public/logos/mina.png",
    url: null,
  },
  {
    id: "vim",
    file: "vim.svg",
    local: null,
    url: "https://upload.wikimedia.org/wikipedia/commons/9/9f/Vimlogo.svg",
  },
  {
    id: "besu",
    file: "besu.svg",
    local: null,
    url: "https://raw.githubusercontent.com/hyperledger/besu-docs/main/static/img/logo.svg",
  },
  {
    id: "dogecoind",
    file: "dogecoind.png",
    local: null,
    url: "https://upload.wikimedia.org/wikipedia/en/d/d0/Dogecoin_Logo.png",
  },
  {
    id: "erigon",
    file: "erigon.png",
    local: null,
    url: "https://avatars.githubusercontent.com/u/67251389",
  },
  {
    id: "nimbus",
    file: "nimbus.svg",
    local: null,
    url: "https://raw.githubusercontent.com/nimbus/nimbus/main/packages/nimbus-ui/public/nimbus-logo.svg",
  },
];

function ipfsUrl(cid) {
  return `${GATEWAY}/ipfs/${cid}`;
}

async function fetchBuffer(url) {
  const res = await fetch(url, {
    headers: { "User-Agent": "operator-readme-logos/1.0" },
    signal: AbortSignal.timeout(30000),
  });
  if (!res.ok) throw new Error(`Fetch ${url} failed: ${res.status}`);
  const ct = res.headers.get("content-type") || "";
  if (ct.includes("text/html") && !url.endsWith(".svg")) {
    throw new Error(`Fetch ${url} returned HTML (${ct})`);
  }
  const buf = Buffer.from(await res.arrayBuffer());
  if (buf.length < 200) throw new Error(`Fetch ${url} too small (${buf.length} bytes)`);
  return { buf, contentType: ct };
}

function readLocal(relPath) {
  const abs = path.join(REPO_ROOT, relPath);
  const buf = fs.readFileSync(abs);
  if (buf.length < 200) throw new Error(`Local ${relPath} too small (${buf.length} bytes)`);
  return buf;
}

async function pinFile(buf, filename, id) {
  const form = new FormData();
  const type = filename.endsWith(".svg")
    ? "image/svg+xml"
    : filename.endsWith(".jpg")
      ? "image/jpeg"
      : "image/png";
  form.append("file", new Blob([buf], { type }), filename);
  form.append(
    "pinataMetadata",
    JSON.stringify({
      name: `operator-logo-${id}`,
      keyvalues: { project: PROJECT, kind: "readme-logo", id },
    }),
  );

  const res = await fetch("https://api.pinata.cloud/pinning/pinFileToIPFS", {
    method: "POST",
    headers: { Authorization: `Bearer ${JWT}` },
    body: form,
    signal: AbortSignal.timeout(60000),
  });
  if (!res.ok) {
    const text = await res.text().catch(() => "");
    throw new Error(`Pinata upload ${id} failed ${res.status}: ${text.slice(0, 200)}`);
  }
  const data = await res.json();
  return data.IpfsHash;
}

async function pollUntilAvailable(cid, maxAttempts = 10) {
  const url = ipfsUrl(cid);
  for (let i = 0; i < maxAttempts; i++) {
    try {
      const r = await fetch(url, { method: "HEAD", signal: AbortSignal.timeout(8000) });
      if (r.ok) return true;
    } catch {
      /* retry */
    }
    await new Promise((r) => setTimeout(r, 3000));
  }
  return false;
}

async function main() {
  const now = new Date().toISOString();
  const logos = [];

  for (const [id, { cid, source }] of Object.entries(REUSE)) {
    console.log(`[reuse] ${id} -> ${cid}`);
    const ok = await pollUntilAvailable(cid);
    if (!ok) throw new Error(`Reused CID not available on gateway: ${id} ${cid}`);
    logos.push({
      id,
      name: `operator-logo-${id}`,
      cid,
      url: ipfsUrl(cid),
      source,
      verifiedAt: now,
    });
  }

  for (const item of UPLOADS) {
    console.log(`[upload] ${item.id}...`);
    let buf;
    let source;
    if (item.local) {
      buf = readLocal(item.local);
      source = `local:${item.local}`;
    } else {
      const fetched = await fetchBuffer(item.url);
      buf = fetched.buf;
      source = item.url;
    }
    const cid = await pinFile(buf, item.file, item.id);
    console.log(`  pinned ${item.id} -> ${cid}`);
    const ok = await pollUntilAvailable(cid);
    if (!ok) throw new Error(`Uploaded CID not available on gateway: ${item.id} ${cid}`);
    logos.push({
      id: item.id,
      name: `operator-logo-${item.id}`,
      file: item.file,
      cid,
      url: ipfsUrl(cid),
      source,
      bytes: buf.length,
      verifiedAt: now,
    });
  }

  logos.sort((a, b) => a.id.localeCompare(b.id));

  const manifest = {
    generatedAt: now,
    gateway: GATEWAY,
    project: PROJECT,
    count: logos.length,
    logos,
  };

  fs.mkdirSync(path.dirname(MANIFEST_PATH), { recursive: true });
  fs.writeFileSync(MANIFEST_PATH, JSON.stringify(manifest, null, 2) + "\n");
  console.log(`\nWrote ${MANIFEST_PATH} (${logos.length} logos)`);
  for (const l of logos) console.log(`  ${l.id}: ${l.url}`);
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
