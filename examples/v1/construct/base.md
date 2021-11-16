# Configure an inventory node with basic setup of:
* installation of Docker engine and custom `Docker` group user set
* hardened SSH access (e.g. no password login allowed, fail2ban intrusion protection)
* automatic/unattended system upgrades
* custom package installations

### curl --request POST --data @base-example.json https://{operator-host-address}:{port}/v1/construct
------------
`> cat operator-example.json`
```json
{
    "id": "base_example_construct",
    "setup": [
        {
            "type": "base",
            "url": "o1labs.cloud.base",
            "properties": {
                "install_docker": true,
                "harden_ssh_access": true,
                "install_fail2ban": true,
                "auto_update": true,
                "docker_users": ["another-example-user"],
                "user_packages": [
                    "curl",
                    "htop",
                    "lsof",
                    "mlocate"
                ]
            }
        }
    ],
    "inventory": [
        {
            "name": "example-node",
            "address": "localhost",
            "user": "example-user",
            "roles": ["base"]
        }
    ]
}
```
