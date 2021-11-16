# Run Kovan Testnet OpenEthereum archive node with warp sync enabled and custom host and container data directories:

### curl --request POST --data @openethereum-example.json https://{operator-host-address}:{port}/v1/construct
------------
`> cat openethereum-example.json`
```json
{
    "id": "openethereum_example_construct",
    "setup": [
        {
            "type": "openethereum",
            "url": "o1labs.crypto.openethereum",
            "properties": {
                "chain": "kovan",
                "warp_barrier": "27183279",
                "host_data_dir": "/home/user/openethereum",
                "data_dir": "/tmp/openethereum",
                "config": {
                    "footprint" : {
                        "pruning": "archive"
                    },
                    "network": {
                        "warp": "true",
                    }
                }
            }
        }
    ],
    "inventory": [
        {
            "name": "example-node",
            "address": "localhost",
            "user": "example-user",
            "roles": ["openethereum"]
        }
    ]
}
```
