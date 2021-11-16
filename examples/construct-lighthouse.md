# Run Lighthouse beacon-chain node and validator on Prater Eth2 testnet (with added dependency chain redundancy), opening HTTP API and metrics endpoints on all host addresses:

### curl --request POST --data @lighthouse-example.json https://{operator-host-address}:{port}/v1/construct
------------
`> cat lighthouse-example.json`
```json
{
    "id": "lighthouse_example_construct",
    "setup": [
        {
            "type": "lighthouse",
            "url": "o1labs.crypto.lighthouse",
            "properties": {
                "eth2_chain": "prater",
                "target_services": [ "beacon-node", "validator" ],
                "setup_validator": "true",
                "host_data_dir": "/var/tmp/lighthouse/data",
                "host_keys_dir": "/var/tmp/lighthouse/keys",
                "beacon_extra_args": "--network=prater --eth1 --http --http-address=0.0.0.0 --http-allow-origin=* --metrics --metrics-address=0.0.0.0 --eth1-endpoints=http://geth:8545,http://ethereum-rpc.goerli.01labs.net:8545,https://goerli.infura.io/v3/4a3a6c645dc94d1b82f8f631a878e03c",
                "validator_extra_args": "--network=prater --enable-doppelganger-protection=true --graffiti=O1 --http --http-address=0.0.0.0 --http-allow-origin=* --metrics --metrics-address=0.0.0.0 --metrics-allow-origin=* --unencrypted-http-transport --beacon-nodes=http://lighthouse-beacon:5052,http://lighthouse.prater.01labs.net:5052"
            }
        }
    ],
    "inventory": [
        {
            "name": "example-node",
            "address": "localhost",
            "user": "example-user",
            "roles": ["lighthouse"]
        }
    ]
}
```
