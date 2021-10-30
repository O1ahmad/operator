:mailbox_with_mail: Operator HTTP API v1
=========

`/v1/construct`
------------

```yaml
[
    {
        path: "/v1/construct",
        method: "GET",
        parameters: "?<id>",
        data: {},
        response:
            [
                {
                    id: "<construct identifier>",
                    type: "<application type or role constructed>",
                    url: "<path to type/role package>",
                    properties: {
                        "property": "value"
                    },
                    inventory: [
                        {
                            name: "name of inventory node (used as default `address` if none provided)",
                            address: "local, ip, dns address used to communicate with inventory node",
                            user: "user authorized to operate node"
                        }
                    ]
                }
            ]
    },
    {
        path: "/v1/construct",
        method: "POST",
        data:
            {
                id: "construct identifier (e.g. Ethereum 2.0 validators, Data Analysis Pipeline)",
                setup: [
                    {
                        type: "<application type or role to construct>",
                        url: "<path to type/role package>",
                        properties: {
                            "property": "value"
                        }
                    }
                ],
                inventory_file: "path to inventory file (if file NOT found and inventory supplied, inventory will be saved at path)",
                inventory: [
                    {
                        name: "name of inventory node (used as default `address` if none provided)",
                        address: "local, ip, dns address used to communicate with inventory node",
                        user: "user authorized to operate node",
                        key: "[XOR-optional] path to user SSH private key - can be local to process (e.g. mounted inside process container) or     supplied encrypted",
                        password: "[XOR-optional] user connection/authorization password",
                    }
                ]
            },
        response: {
            status: "<current status of construct operation>",
            log: "STDOUT/STDERR of construction process"
        }
    }
]
```
