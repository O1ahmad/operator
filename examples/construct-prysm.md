# Run Pryms beacon-chain node and validator on Prater Eth2 testnet (based on Goerli Ethereum Testnet) with database backups saved to custom host path:

### curl --request POST --data @prysm-example.json https://{operator-host-address}:{port}/v1/construct
------------
`> cat prysm-example.json`
```json
{
    "id": "prysm_example_construct",
    "setup": [
        {
            "type": "prysm",
            "url": "o1labs.crypto.prysm",
            "properties": {
                "eth2_chain": "prater",
                "target_services": [ "beacon-node", "validator" ],
                "host_data_dir": "/var/tmp/prysm",
                "data_dir": "/data",
                "beacon_config":{
                    "prater": "true",
                    "db-backup-output-dir": "/data/backups",
                    "http-web3provider": "http://geth:8545,http://ethereum-rpc.goerli.01labs.net:8545"
                },
                "validator_config": {
                    "prater": "true",
                    "db-backup-output-dir": "/data/backups"
                }
            }
        }
    ],
    "inventory": [
        {
            "name": "example-node",
            "address": "localhost",
            "user": "example-user",
            "roles": ["prysm"]
        }
    ]
}
```
