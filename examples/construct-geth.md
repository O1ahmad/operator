# Run Mainnet light client node with increased logging (in JSON format) and custom host data directory:

### curl --request POST --data @geth-example.json https://{operator-host-address}:{port}/v1/construct
------------
`> cat geth-example.json`
```json
{
    "id": "geth_example_construct",
    "setup": [
        {
            "type": "geth",
            "url": "o1labs.crypto.geth",
            "properties": {
                "host_data_dir": "/mnt/my/geth/data",
                "log_mode": "json",
                "verbosity_level": "warn",
                "config": {
                    "Eth": {
                        "SyncMode": "light"
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
            "roles": ["geth"]
        }
    ]
}
```

# Run Goerli testnet fast sync node with automatic daily backups of custom keystore (or data) directory:
------------
`> cat geth-example.json`
```json
{
    "id": "geth_example_construct",
    "setup": [
        {
            "type": "geth",
            "url": "o1labs.crypto.geth",
            "properties": {
                "chain": "goerli",
                "config": {
                    "Eth": {
                        "SyncMode": "fast"
                    }
                },
                "env_vars": {
                    "AUTO_BACKUP_KEYSTORE": "true",
                    "KEYSTORE_DIR": "/tmp/keystore",
                    "BACKUP_INTERVAL": "0 * * * *",
                    "BACKUP_PASSWORD": "<secret>"
                }
            }
        }
    ],
    "inventory": [
        {
            "name": "example-node",
            "address": "localhost",
            "user": "example-user",
            "roles": ["geth"]
        }
    ]
}
```
