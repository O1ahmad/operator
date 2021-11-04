:mailbox_with_mail: Operator HTTP API v1
=========

`/v1/construct`
------------

Retrieve or construct an environment based on a defined host inventory and roles/role properties. 

```yaml
[
    {
        path: "/v1/construct",
        method: "GET",
        parameters: "?<id>",
        data: {},
        response: {
            id: "<construct-identifier>",
            message: "message indicating status of operation execution",
            construct(s): [
                "<json-construct-object>"
            ]
        }
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
                        roles: ["roles to associate with host (match with list of types provided in <setup>"],
                        # password can also be supplied interactively to avoid store
                        password: "[XOR-optional] user connection/authorization password",
                    }
                ]
            },
        response: {
            id: "<construct-identifier>",
            message: "message indicating status of operation execution",
            construct: [
                "<json-construct-object>"
            ]
        }
    }
]
```

`/v1/view`
------------

View role/host facts and metadata according to specified query parameters. 

```yaml
[
    {
        path: "/v1/view/<construct-identifier>",
        method: "GET",
        parameters: "?<ssh_key>&<target>&<hosts>&<filter>",
        data: {},
        response:
            {
                id: "<construct-identifier>",
                message: "message indicating status of operation execution",
                view: {
                    "<host-facts>"
                }
            }
    }
]
```

`/v1/key`
------------

Upload an SSH key to be used for remote inventory operations.

```yaml
[
    {
        path: "/v1/key",
        method: "POST",
        parameters: "N/A",
        data: {},
        file: "ssh",
        response: {
            message: "message indicating status of operation execution"
        }
    }
]
```
