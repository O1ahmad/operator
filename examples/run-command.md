# Run Geth sync progress check using O1's geth-helper utility against geth inventory nodes for a given construct ID:

### curl --request POST --data @run-example.json https://{operator-host-address}:{port}/v1/run/{cid}?target=geth
------------
`> cat run-example.json`
```json
{
    "run_args": "docker exec geth geth-helper status sync-progress"
}
```
