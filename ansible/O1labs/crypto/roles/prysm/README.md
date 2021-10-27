<p><img src="https://code.benco.io/icon-collection/logos/ansible.svg" alt="ansible logo" title="ansible" align="left" height="60" /></p>
<p><img src="https://prysmaticlabs.com/assets/PrysmStripe.png" alt="Prysm logo" title="prysm" align="right" height="60" /></p>

Ansible Role :stars: :link: Prysm
=========

Configure and operate Prysm: A full-featured client for the Ethereum 2.0 protocol, written in Go.

Requirements
------------

[Docker SDK](https://docker-py.readthedocs.io/en/stable/) for Python (for Python 2.6 support, use the deprecated `docker-py` library instead) or installation of the `docker` and `docker-compose` tools.

Role Variables
--------------

| var | description | default |
| :---: | :---: | :---: |
| *image* | Prysm client container image to deploy | `0labs/prysm:latest` |
| *prysm_config_dir* | configuration directory path within container | `/etc/prysm` |
| *eth2_chain* | Ethereum 2.0 chain to target during client helper operations | `pyrmont` |
| *p2p_tcp_port* | peer-to-peer network communication and listening port | `13000` |
| *p2p_udp_port* | peer-to-peer network discovery port | `12000` |
| *eth2_api_port* | Ethereum 2.0 RESTful HTTP API listening port | `3501` |
| *beacon_rpc_port* | RPC port exposed by a beacon node | `4000` |
| *beacon_metrics_port* | port used to listen and respond to metrics requests for prometheus | `8080` |
| *validator_gateway_port* | gRPC gateway for JSON requests | `7500` |
| *validator_rpc_port* | RPC port exposed by a validator client | `7000` |
| *validator_metrics_port* | port used to listen and respond to metrics requests for prometheus | `8081` |
| *host_data_dir* | host directory to store node runtime/operational data | `/var/tmp/prysm` |
| *data_dir* | container directory to store node runtime/operational data | `/data` |
| *host_wallet_dir* | host directory to store node account wallets | `/var/tmp/prysm/wallets` |
| *host_keys_dir* | host directory to store node account keys | `/var/tmp/prysm/keys` |
| *beacon_env_vars* | path to environment file to load by compose Beacon node container (see [list](https://docs.prylabs.network/docs/prysm-usage/parameters/#beacon-node-configuration) of available config options) | `/var/tmp/prysm/.beacon.env` |
| *validator_env_vars* | Path to environment file to load by compose Validator container (see [list](https://docs.prylabs.network/docs/prysm-usage/parameters/#validator-configuration)) of available config options | `/var/tmp/prysm/.validator.env` |
| *setup_mode* | infrastructure provisioning setup mode (either `compose`, leveraging **docker-compose**, or `systemd` are supported) | `compose` |
| *target_state* | desired role deployment state (either *present* or *absent*) | `present` |
| *target_services* | list of services to include in deployment process (`beacon-node` and/or `validator`) | `["beacon-node", "validator"]` |
| *_ops_runtime_dir* | operational directory to store runtime artifacts | `/var/tmp/prysm` |
| *setup_deposit_cli* | whether to download the Eth 2.0 deposit CLI maintained at https://github.com/ethereum/eth2.0-deposit-cli | `false` |
| *deposit_cli_version* | version of the Eth 2.0 deposit CLI to download | `v1.2.0` |
| *setup_deposit_accounts* | whether to automatically setup Eth 2.0 validator depositor accounts ([see](https://github.com/ethereum/eth2.0-deposit-cli#step-2-create-keys-and-deposit_data-json) for more details) | `false` |
| *deposit_dir* | container directory to generate Eth 2.0 validator deposit keystores | `/var/tmp/deposit` |
| *deposit_mnemonic_lang* | language to generate deposit mnemonic in | `english` |
| *deposit_num_validators* | count of Eth 2.0 validator deposit keystores to generate | `1` |
| *deposit_key_password* | validator deposit keystore password associated with generated mnemonic | `passw0rd` |
| *setup_validator* | whether to attempt to import validator keystores and associated wallets | `false` |
| *validator_wallet_password* | password to secure validator wallet associated with imported keystore | `N/A` |
| *validator_account_password* | password to secure validator account | `N/A` |
| *auto_backup_db* | whether to automatically execute database backups based on | `false` |
| *backup_interval* | database backup frequency based on a cron schedule | `0 */6 * * *` |
| *restart_policy* | container restart policy | `unless-stopped` |
| *beacon_config* | beacon chain node configuration options settings | `{}` **note:** reference `defaults/main.yml` |
| *validator_config* | validator client configuration options settings | `{}` **note:** reference `defaults/main.yml` |

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

* Enable automatic acceptance of the terms of use when launching either a beacon-chain or validator node:
```
  - role: 0x0I.prysm
    vars:
      beacon_config:
        accept-terms-of-use: true
```

* Launch a Prysm beacon-chain node connected to the Pyrmont Ethereum 2.0 testnet using a Goerli web3 Ethereum provider:
```
  - role: 0x0I.prysm
    vars:
      beacon_config:
        http-web3provider: http://ethereum-rpc.goerli.01labs.net:8545
        pyrmont: true
```

* Customize the deploy container image and host + container node data directory:
```
  - role: 0x0I.prysm
    vars:
      image: 0labs/prysm:v2.0.0
      host_data_dir=/my/host/data
      data_dir: /container/data/dir
```

* Install Eth2 deposit CLI tool and automatically setup multiple validator accounts/keys to register on the Prater testnet:
```
  - role: 0x0I.prysm
    vars:
      setup_deposit_cli: true
      eth2_chain: prater
      deposit_cli_version: v1.2.0
      setup_deposit_accounts: true
      deposit_num_validators: 3
      deposit_key_password: ABCabc123!@#$
```

* Setup automatic cron backups of a localhost beacon-chain node DB every 12 hours (or twice a day):
```
  - role: 0x0I.prysm
    vars:
      target_services: ["beacon-node']
      auto_backup_db: true
      backup_host_addr: http://localhost:8080
      backup_interval: "0 */12 * * *"
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
