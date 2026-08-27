<p><img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/QmRuw4duqLhb9n1DxFZBgrXk9KNyPATSmRDkxd84VZp17Z" alt="0xO1 logo" title="0xO1" align="right" height="80" /></p>

🌎 O1 Labs
=========
![GitHub release (latest by date)](https://img.shields.io/github/v/release/0x0I/operator?color=yellow)
[![Docker Pulls](https://img.shields.io/docker/pulls/0labs/operator?style=flat)](https://hub.docker.com/repository/docker/0labs/operator)
[![License: MIT](https://img.shields.io/badge/License-MIT-blueviolet.svg)](https://opensource.org/licenses/MIT)

**in·fra·struc·ture/ˈinfrəˌstrək(t)SHər/**

    1. the basic physical and organizational structures and facilities (e.g. buildings, roads, power supplies) needed for the operation of a society or enterprise.

*O1 Labs is an open, decentralized and managed infrastructure/operations service platform dedicated to the development, provisioning and support of ALL things cloud-native and web3.*

Ranging from cloud-native services/applications (e.g. `prometheus, kafka, fluentd`) to blockchain network nodes and validators to an assortment of development and operational tools (e.g. `git, vim, tmux`), **O1** strives to enhance all technological ecosystems with encoded expert & experienced operational logic and insights via the most established and developed software automation tools, human-computer vizualization and interaction techniques and best practices - crafted and curated by a decentralized, world-wide community of researchers, developers, operators and hobbyists/enthusiasts.

# Operator

See [Project Overview](https://github.com/0x0I/operator/blob/master/docs/overview.md)

**Operator** is the first `User-Interface-as-a-Service (UIaaS)` aimed at optimizing the way users interact with the myriad of open-source and proprietary services available on the web. Typically, the de facto interface used between users and these services is a command-line interface or CLI which depends on terminal programs distributed across the major OS platforms (Windows, Mac, Linux). These types of interfaces are text-based, prone to typing errors, challenging to learn/remember, "noisy" by nature and are overall considerably less efficient in terms of productivity when compared to more graphical user-interfaces; especially those based on the sciences & principles of Human-Computer Interaction and Information Design.

<img src="https://miro.medium.com/max/786/1*4jGCY6YznCuRlYiLPaL27A.webp">

*Figure 1. example of a command-line interface*

**Operator** is a service that ultimately seeks to provide an extensible, web-based graphical user-interface which serves as a proxy between how users visualize and manipulate the data and behaviors of each service while offering resource provisioning and productivity enhancing features such as installing and uninstalling applications, adding logging and metric observability, remembering and performing intellisense on commands, setting custom user profiles and sharing operational insights/best practices with the world at large. It can run from anywhere (locally or remote), on any of the major OS platforms and can be exposed and accessed via HTTPS/HTTP managing nodes using ONLY SSH and private-public key cryptography.

Leveraging `Dockerfiles`, `Helm charts`, `Ansible roles/collections` etc built world-wide (and with a steadfast dedication rooted at the project's core to the latest and greatest tools involved in infrastructure automation and HCI as a standard), **O1** aims to literally elevate the idea of computer interfaces and infrastructure providers to the :cloud: by building decentralized user-interface and DevOps platforms which push the boundary of the capabilities of the modern web; leaving the dark, archaic CLI and terminal days in the rearview.

Checkout `v1` of the [REST API](https://github.com/0x0I/operator/tree/master/docs/examples/v1) to **Get Started**!

# Applications

## O1labs.cloud

| role name | description|
| :---: | :---: |
| <img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/QmRuw4duqLhb9n1DxFZBgrXk9KNyPATSmRDkxd84VZp17Z"  width="75" height="75"> [operator](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/operator/README.md) | an open and decentralized managed infrastructure and operations service |
| <img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/QmYV99miQWATMmHkPy45Ss58FvotDkPirTmsrH382JGv9u"  width="75" height="75"> [base](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/base/README.md) | setup of basic virtualization and security system services supporting cloud-native infrastructure |
| <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ60AoXxR3Ah2xZm4mZzyqrNUByGtXzjKqPptZaUX5NMw&s"  width="75" height="75"> [ansible](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/ansible/README.md) | a software provisioning, configuration management and application-deployment tool |
| <img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/bafkreic2sykvvovr7oqwie25e3ssxf6k4oyqvpa55yusjyc2co7u2xhxnu"  width="75" height="75"> [consul](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/consul/README.md) | a service discovery, mesh and configuration control plane and networking tool |
| <img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/bafkreieogv5w4tf6zmj2iywnrwrzqus5xzmzxnzbbrscn4xrca3qevqycy"  width="75" height="75"> [elasticsearch](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/elasticsearch/README.md) | a real-time distributed search and analytics engine |
| <img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/bafkreif5slz4sqxe4j23b5ztqarp7t6n4c36lcq3do3ouwap4ia463p7ji"  width="75" height="75"> [fluentd](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/fluentd/README.md) | a unified and scalable logging and data collection service |
| <img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/bafkreigq7pekrv2r7cmhnic7coq5x45ddtonnkcud46tlryv7ds3jwhrzq"  width="75" height="75"> [grafana](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/grafana/README.md) | an analytics and monitoring observability platform |
| <img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/QmYtGaNWcEMwHbJouxkCFQczXxV1bfdXccL2FwbbBskom9"  width="75" height="75"> [journald](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/journald/README.md) | a system service which collects and stores logging data |
| <img src="https://pbs.twimg.com/profile_images/781633389577195521/kazUJooF_400x400.jpg"  width="75" height="75"> [kafka](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/kafka/README.md) | a distributed and fault tolerant stream-processing service |
| <img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/QmRNPWJJ8KH8xxUrFhg2amx76UMHXyCgSKcnEA1yAMLRWE"  width="75" height="75"> [kibana](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/kibana/README.md) | an analytics and visualization platform designed to operate with Elasticsearch |
| <img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/QmTZMSBmkVsDPpq4wiZ2mn13tW2dQH1gBVHQ4wvYbKzwDR"  width="75" height="75"> [openssh](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/openssh/README.md) | a remote login and operations tool based on the **SSH protocol** |
| <img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/QmXriziea54HnY2AHZuHed9DNkB3HtNTqYmguDBjvaiotX"  width="75" height="75"> [phoronix](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/phoronix/README.md) | a comprehensive & extensible testing and benchmarking platform for a range of hardware and machine subsystems |
| <img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/bafkreifjnvemy7y4shpjidnmx4yfqgcq7uwa5vfpv4nqxfh3q3vr2cxpny"  width="75" height="75"> [prometheus](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/prometheus/README.md) | a multi-dimensional, non-distributed time-series database and monitoring/alerting toolkit |
| <img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/QmYtGaNWcEMwHbJouxkCFQczXxV1bfdXccL2FwbbBskom9"  width="75" height="75"> [systemd](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/systemd/README.md) | system components and services managed by the Linux `systemd` system/service manager |
| <img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/QmYXtUZMrnVQHKQxbpC47Pva5CrhdPfQ83Nfr7EwCb6i9L"  width="75" height="75"> [tmux](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/tmux/README.md) | a terminal multiplexer enabling multiple terminals to be created, accessed, and controlled from a single screen |
| <img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/QmSNmWt1QNJK61doCcvNviQo1eEbr9WgZKAdYAt3vThzn5"  width="75" height="75"> [traefik](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/traefik/README.md) | a dynamic service reverse-proxy and load-balancer |
| <img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/QmTZkSCSC6XeJ4J7iWppJqoJGBYX4Unw5bCiWRTN3QM2sU"  width="75" height="75"> [vim](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/vim/README.md) | a powerful and flexible text editor and development environment |

## O1labs.crypto

| name | description|
| :---: | :---: |
| <img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/bafkreibjy2uuw36nuieuutxto7k6tuvvoy5vfbsiugnu3blntur42vg2ye"  width="60" height="60"> [avalanchego](https://hub.docker.com/repository/docker/0labs/avalanchego/general) | Go implementation of an Avalanche node |
| <img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/QmSjep865teXhhN8od3DmDLVpUCLqevc75xGgFbYXojUtt"  width="125" height="75"> [besu](https://hub.docker.com/repository/docker/0labs/besu/general) | an open source Ethereum client developed under the Apache 2.0 license and written in Java |
| <img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/bafkreih4mag7tt75x3lxxcgg6tx5wsitcdypqti3fvmdq6kyypcb5fieoy"  width="75" height="75"> [bitcoind](https://hub.docker.com/repository/docker/0labs/bitcoind/general) | Client software for running a Bitcoin Core node |
| <img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/QmW64bU4jRwK1tuUvwNw6d9YivUChq7CheMHqLTCxbaJjs"  width="60" height="60"> [bitcoin-abc](https://hub.docker.com/repository/docker/0labs/bitcoin-abcd/general) | Node software for the Bitcoin Cash/eCash project |
| <img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/QmUr34ZTfn6ps7PY4kfXg5vvkBMcou7dkNVs8RVevVkSNo"  width="50" height="50"> [chainlink](https://github.com/0x0I/operator/blob/master/ansible/O1labs/crypto/roles/chainlink/README.md) | an implementation of the Chainlink decentralized oracle network and smart-contract platform node |
| <img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/QmPhiNuRiDEmpsnFrwGwQhXFk472HFkG1BRakuRgDdR4V7"  width="60" height="60"> [dogecoind](https://hub.docker.com/repository/docker/0labs/dogecoind) | Node software for the Dogecoin blockchain network |
| <img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/QmSprAWHztw9YgRbcBP91dwYdEeFPtWcck3jGiZ9B8bgmA" width="75" height="75"> [erigon](https://hub.docker.com/repository/docker/0labs/erigon) | an implementation of Ethereum (execution client), on the efficiency frontier, written in Go |
| <img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/QmQKan5FXqoR5tB5X9aD58FJWwwJAkMjxWEKZWG6pTTf6R"  width="75" height="75"> [geth](https://github.com/0x0I/operator/blob/master/ansible/O1labs/crypto/roles/geth/README.md) | an Ethereum blockchain client written in Go |
| <img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/bafybeibl42ysp5ndusxw556eww2vbzvu3bsgmiljnkkvrov272yuqsboei"  width="75" height="75"> [lighthouse](https://github.com/0x0I/operator/blob/master/ansible/O1labs/crypto/roles/lighthouse/README.md) | an Ethereum consensus client, written in Rust and maintained by Sigma Prime |
| <img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/QmVvR1mh9hxqEafYUmAuoRo73CZnipv6vT9jZTqkQAJUNv"  width="75" height="75"> [litecoind](https://hub.docker.com/repository/docker/0labs/litecoin) | Node software for the Litecoin digital currency payments network |
| <img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/QmYAuxeunHe2eYc8ePcjn8tPQHz4MnzQWj6H4khRxx75r4" width="75" height="75"> [lodestar](https://hub.docker.com/repository/docker/0labs/lodestar/general) | an open-source Ethereum consensus client and Typescript ecosystem |
| <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRe7lR0_OVIJM3kQbeUpBnaSTEpBKpQJcD-CidXalDT8g&s" width="75" height="75"> [lotus](https://github.com/0x0I/operator/tree/master/ansible/O1labs/crypto/roles/lotus) | a Go-implementation of the Filecoin distributed storage network blockchain protocol |
| [<img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/QmVbz98LvGNMCGo8Y7tisov5Z4uteMTcESUGVzoCtPiLUP"  width="125" height="60">](https://hub.docker.com/repository/docker/0labs/mev-boost/general) | a proposer-builder separation (PBS) implementation/middleware run by ETH validators to access a competitive block-building market based on Maximal Extractable Value (MEV) |
| <img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/QmYD2RcqPkpAfcJd3jeKYgm1Lot5LggxCwN8LruuPdsYbh" width="75" height="75"> [mina](https://github.com/0x0I/operator/blob/master/ansible/O1labs/crypto/roles/mina/README.md) | client node a part of Mina's succinct zero-knowledge protocol based on recursive composition of zk-SNARKs |
| [<img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/bafkreifkwewrtjbuvosxbyaxnjbg6jzywowen7vtbyoahqzl7jj6bizzaq"  width="125" height="60">](https://hub.docker.com/repository/docker/0labs/nethermind/general) | an Ethereum protocol execution client built on .NET |
| <img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/QmWEALttGHpkNdhRC83Ndu8pDmDo4v8qCvvP1ywU4LQXr6" width="75" height="75"> [nimbus](https://hub.docker.com/repository/docker/0labs/nimbus/general) | a lightweight Ethereum consensus client developed by the Status Network |
| <img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/bafkreib3f6ihq5nlk5mr5gqzjuyphcjeni7mmfz3a4ubbtv62duokm2fgi"  width="75" height="75"> [prysm](https://github.com/0x0I/operator/blob/master/ansible/O1labs/crypto/roles/prysm/README.md) | a full-featured client for the Ethereum consensus protocol, written in Go |
| <img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/bafkreib2zhqroplh53c4eabwbx3ddbpq47cp3suftldss6tvjy6luxp3jq"  width="75" height="75"> [teku](https://github.com/0x0I/operator/blob/master/ansible/O1labs/crypto/roles/teku/README.md) | an open-source Ethereum consensus client written in Java |
| <img src="https://aqua-characteristic-rabbit-42.mypinata.cloud/ipfs/bafkreifuwnagjvm6tvrz5ztwjwkrtnzjjvdgalqwimn432r4ozp4j6fwwa" width="75" height="75"> [zcash](https://github.com/0x0I/operator/blob/master/ansible/O1labs/crypto/roles/zcash/README.md) | a client for the Zcash zero-knowledge privacy blockchain/protocol |
