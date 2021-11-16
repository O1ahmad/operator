# Run Teku beacon-chain and validator nodes with:
* Eth2 Mainnet
* dependency chain endpoint redundancy
* custom host and container data directories
* initial state snapshot syncing enabled
* both HTTP and metrics APIs listening on all interfaces
* automatic setup of Eth2 deposit validator keys and activation

### curl --request POST --data @teku-example.json https://{operator-host-address}:{port}/v1/construct
------------
`> cat teku-example.json`
```json
{
    "id": "teku_example_construct",
    "setup": [
        {
            "eth2_chain": "mainnet",
            "target_services": [ "beacon-node", "validator" ],
            "eth1_endpoints": "http://geth:8545,http://ethereum-rpc.mainnet.01labs.net:8545,https://mainnet.infura.io/v3/4a3a6c645dc94d1b82f8f631a878e03c",
            "host_data_dir": "/var/tmp/teku/data",
            "data_dir": "/data",
            "beacon_config": {
                "network": "mainnet",
                "initial-state": "https://1zmZfn5jwHnW8kxtZ8JKZobXNge:4a7c68d25f0278b47bf77b2cdc2ea21f@eth2-beacon-mainnet.infura.io/eth/v1/debug/beacon/states/finalized",
                "rest-api-enabled": true,
                "rest-api-interface": "0.0.0.0",
                "rest-api-host-allowlist": "*",
                "metrics-enabled": true,
                "metrics-interface": "0.0.0.0",
                "metrics-host-allowlist": "*"
            },
            "beacon_env_vars": {
                "SETUP_DEPOSIT_CLI": true,
                "SETUP_DEPOSIT_ACCOUNTS": true,
                "DEPOSIT_NUM_VALIDATORS": 1,
                "DEPOSIT_KEY_PASSWORD": "ABCabc123!@#$",
                "DEPOSIT_DIR": "/data/deposits"
            },
            "validator_config": {
                "network": "mainnet",
                "beacon-node-api-endpoint": "http://teku-beacon:5051,http://teku.mainnet.01labs.net:5051"
            },
            "validator_env_vars": {
                "SECURITY_OUTPUT_DIR": "/data/secure/dir",
                "SETUP_VALIDATOR": true,
                "VALIDATOR_KEY": "/data/deposits/validator_keys/<key>",
                "VALIDATOR_KEY_PASSWORD": "ABCabc123!@#$"
            },
        }
    ],
    "inventory": [
        {
            "name": "example-node",
            "address": "localhost",
            "user": "example-user",
            "roles": ["teku"]
        }
    ]
}
```
