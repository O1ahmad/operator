# Run Mainnet Chainlink node with API and wallet credentials set and all API request origins allowed:

### curl --request POST --data @chainlink-example.json https://{operator-host-address}:{port}/v1/construct
------------
`> cat chainlink-example.json`
```json
{
    "id": "chainlink_example_construct",
    "setup": [
        {
            "type": "chainlink",
            "url": "o1labs.crypto.chainlink",
            "properties": {
                "env_vars": {
                    "OPERATOR_PASSWORD": "ABCabc123!@#$",
                    "API_USER": "linknode@example.com",
                    "API_PASSWORD": "passw0rd",
                },
                "config": {
                    "ETH_CHAIN_ID" : "1",
                    "LINK_CONTRACT_ADDRESS": "0x514910771af9ca656af840dff83e8264ecf986ca",
                    "ETH_URL": "ws://ethereum-rpc.mainnet.01labs.net:8546",
                    "ALLOW_ORIGINS": "*"
                }
            }
        }
    ],
    "inventory": [
        {
            "name": "example-node",
            "address": "localhost",
            "user": "example-user",
            "roles": ["chainlink"]
        }
    ]
}
```
