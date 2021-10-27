<p><img src="https://code.benco.io/icon-collection/logos/ansible.svg" alt="ansible logo" title="ansible" align="left" height="60" /></p>
<p><img src="https://cryptomode.com/wp-content/uploads/2020/08/CryptoMode-chainLink-Price-696x392.jpg" alt="0xO1 logo" title="0xO1" align="right" height="100" /></p>

Ansible Role :crystal_ball: :link: Chainlink
=========

Configure and operate Chainlink: a smart-contract platform data oracle network.

Requirements
------------

[Docker SDK](https://docker-py.readthedocs.io/en/stable/) for Python (for Python 2.6 support, use the deprecated `docker-py` library instead) or installation of the `docker` and `docker-compose` tools.

Role Variables
--------------

| var | description | default |
| :---: | :---: | :---: |
| *image* | Chainlink service container image to deploy | `0labs/chainlink:latest` |
| *ui_port* | Chainlink node operation web UI service port | `6688` |
| *https_port* | Chainlink node operation web UI HTTPS service port | `6689` |
| *postgres_image* | Postgres DB image to deploy | `postgres:latest` |
| *postgres_user* | username to access backend postgres database | `postgres` |
| *postgres_password* | password to access required backend postgres database | `secret` |
| *postgres_host* | host address of backend postgres database | `postgres` |
| *postgres_port* | Postgres DB container listening port | `5432` |
| *postgres_db* | database name of backend postgres instance | `postgres` |
| *PGDATA* | Postgres data directory | `/var/lib/postgresql/data` |
| *host_data_dir* | host directory to store node runtime/operational data | `/var/tmp/chainlink` |
| *data_dir* | container directory to store node runtime/operational data | `/chainlink` |
| *restart_policy* | container restart policy | `unless-stopped` |` |
| *sslmode* | postgres db SSL encrypted access support mode (see [here](https://www.postgresql.org/docs/9.1/libpq-ssl.html) for more details) | `disable` |
| *env_vars* | Path to environment file to load | `/var/tmp/chainlink/.env` |
| *config* | node operator runtime config environment (see [here](https://docs.chain.link/docs/configuration-variables/) for available options) | `disable` |
| *setup_mode* | infrastructure provisioning setup mode (either `compose`, leveraging **docker-compose**, or `systemd` are supported) | `compose` |
| *target_state* | desired role deployment state (either *present* or *absent*) | `present` |
| *target_services* | list of services to include in deployment process (`chainlink` and/or `postgres`) | `["chainlink", "postgres"]` |
| *ops_runtime_dir* | operational directory to store runtime artifacts | `/var/tmp/chainlink` |
| *security_output_dir* | directory within container to maintain secure credentials files | `/var/tmp/chainlink` |

Dependencies
------------
```
collections:
- name: community.docker
```
Example Playbook
----------------
```
- hosts: servers
  roles:
```

* Launch a Chainlink node connected to the Rinkeby Ethereum testnet:
```
  - role: 0x0I.chainlink
    vars:
      security_output_dir: /mnt/secure
      config:
        OPERATOR_PASSWORD: ABCabc123!@#$
        API_USER: linknode@example.com
        API_PASSWORD: passw0rd
        ETH_CHAIN_ID: 4
        LINK_CONTRACT_ADDRESS: 0x01BE23585060835E02B77ef475b0Cc51aA1e0709
        ETH_URL: ws://ethereum-rpc.rinkeby.01labs.net:8546
```

* Deploy non-default Chainlink node container image againt Ethereum mainnet with debug logging:
```
  - role: 0x0I.chainlink
    vars:
      image: 0labs/chainlink:v0.10.13
      config:
        OPERATOR_PASSWORD: ABCabc123!@#$
        API_USER: linknode@example.com
        API_PASSWORD: passw0rd
        ETH_CHAIN_ID: 1
        ETH_URL: ws://ethereum-rpc.mainnet.01labs.net:8546
        LOG_LEVEL: debug
```

* Allow node API service to accept incoming requests for all interfaces and enable backup Ethereum nodes:
```
  - role: 0x0I.chainlink
    vars:
      config:
        ALLOW_ORIGINS: "*"
        ETH_URL: ws://ethereum-rpc.mainnet.01labs.net:8546
        ETH_HTTP_URL: http://ethereum-rpc.mainnet.01abs.net:8545
        ETH_SECONDARY_URLS: https://mainnet.infura.io/v3/<YOUR-PROJECT-ID>,https://mainnet.rpc-backup:8545
```

* Activate HTTPS connections to the API service and store generated certificates at custom host location:
```
  - role: 0x0I.chainlink
    vars:
      sslmode=prefer
      config:
        ENABLE_HTTPS: true
        SECURITY_OUTPUT_DIR: /chainlink/secure/
        SECURITY_CERT_DURATION: 30
```

* Connect to non-default Postres db instance with custom credentials:
```
  - role: 0x0I.chainlink
    vars:
      postgres_host=my-postgres.prod.instance
      postgres_db=chainlink
      postgres_user=my-user
      postgres_password=topsecret
```

License
-------

MIT

Author Information
------------------

This Ansible role was created in 2021 by O1.IO.

🏆 **always happy to help & donations are always welcome** 💸

* **ETH (Ethereum):** 0x652eD9d222eeA1Ad843efec01E60C29bF2CF6E4c

* **BTC (Bitcoin):** 3E8gMxwEnfAAWbvjoPVqSz6DvPfwQ1q8Jn

* **ATOM (Cosmos):** cosmos19vmcf5t68w6ug45mrwjyauh4ey99u9htrgqv09
