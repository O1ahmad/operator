<p><img src="https://code.benco.io/icon-collection/logos/ansible.svg" alt="ansible logo" title="ansible" align="left" height="60" /></p>
<p><img src="https://pbs.twimg.com/profile_images/1324063968877563907/n-NYkVty.png" alt="teku logo" title="teku" align="right" height="80" /></p>

Ansible Role 🔰:link: Teku
=========

Configure and operate Teku: an open-source Ethereum 2.0 client written in Java.

Requirements
------------

[Docker SDK](https://docker-py.readthedocs.io/en/stable/) for Python (for Python 2.6 support, use the deprecated `docker-py` library instead) or installation of the `docker` and `docker-compose` tools.

Role Variables
--------------

| var | description | default |
| :---: | :---: | :---: |
| *image* | Teku client container image to deploy | `0labs/teku:latest` |
| *teku_config_dir* | configuration directory path within container | `/etc/teku` |
| *eth1_endpoints* | Comma-separated list of JSON-RPC URLs of Ethereum 1.0 nodes | `http://ethereum-rpc.goerli.01labs.net` |
| *eth2_chain* | Ethereum 2.0 chain to target during client helper operations | `pyrmont` |
| *p2p_tcp_port* | peer-to-peer network communication and listening port | `9000` |
| *p2p_udp_port* | peer-to-peer network discovery port | `9000` |
| *beacon_api_port* | HTTP API port exposed by a beacon node | `5051` |
| *beacon_metrics_port* | port used to listen and respond to metrics requests for prometheus | `8008` |
| *validator_metrics_port* | port used to listen and respond to metrics requests for prometheus | `8009` |
| *host_data_dir* | host directory to store node runtime/operational data | `/var/tmp/teku` |
| *data_dir* | container directory to store node runtime/operational data | `/data` |
| *host_wallet_dir* | host directory to store node account wallets | `/var/tmp/teku/wallets` |
| *host_keys_dir* | host directory to store node account keys | `/var/tmp/teku/keys` |
| *beacon_env_vars* | path to environment file to load by compose Beacon node container (see [list](https://docs.teku.consensys.net/en/latest/Reference/CLI/CLI-Syntax/) of available config options) | `.beacon.env` |
| *validator_env_vars* | Path to environment file to load by compose Validator container (see [list](https://docs.teku.consensys.net/en/latest/Reference/CLI/Subcommands/Validator-Client/) of available config options | `.validator.env` |
| *setup_mode* | infrastructure provisioning setup mode (either `compose`, leveraging **docker-compose**, or `systemd` are supported) | `compose` |
| *target_state* | desired role deployment state (either *present* or *absent*) | `present` |
| *target_services* | list of services to include in deployment process (`beacon-node` and/or `validator`) | `["beacon-node", "validator"]` |
| *_ops_runtime_dir* | operational directory to store runtime artifacts | `/var/tmp/teku` |
| *setup_deposit_cli* | whether to download the Eth 2.0 deposit CLI maintained at https://github.com/ethereum/eth2.0-deposit-cli | `false` |
| *deposit_cli_version* | version of the Eth 2.0 deposit CLI to download | `v1.2.0` |
| *setup_deposit_accounts* | whether to automatically setup Eth 2.0 validator depositor accounts ([see](https://github.com/ethereum/eth2.0-deposit-cli#step-2-create-keys-and-deposit_data-json) for more details) | `false` |
| *deposit_dir* | container directory to generate Eth 2.0 validator deposit keystores | `/var/tmp/deposit` |
| *deposit_mnemonic_lang* | language to generate deposit mnemonic in | `english` |
| *deposit_num_validators* | count of Eth 2.0 validator deposit keystores to generate | `1` |
| *deposit_key_password* | validator deposit keystore password associated with generated mnemonic | `passw0rd` |
| *setup_validator* | whether to attempt to import validator keystores and associated wallets | `false` |
| *security_output_dir* | directory to store secure/sensitive validator data | `/var/tmp/teku` |
| *validator_key* | validator keystore value in json format | `N/A` |
| *validator_key_password* | validator keystore password | `N/A` |
| *validator_keys_dir* | Path to a directory where validator keystores to be imported are stored | `N/A` |
| *validator_pwd_password* | Path to a directory where validator keystore passwords are stored | `N/A` |
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

* Launch a Teku beacon-chain node connected to the Pyrmont Ethereum 2.0 testnet using a Goerli web3 Ethereum endpoint:
```
  - role: 0x0I.teku
    vars:
      eth1_endpoints: http://ethereum-rpc.goerli.01labs.net:8545
      beacon_config:
        network: pyrmont
```

* Customize the deploy container image and host + container node data directory:
```
  - role: 0x0I.teku
    vars:
      image: 0labs/teku:v21.10.1
      host_data_dir=/my/host/data
      beacon_config:
        data-path: /container/data/dir
```

* Enable and expose beacon node HTTP API and metrics server on all interfaces:
```
  - role: 0x0I.teku
    vars:
      beacon_config:
        rest-api-enabled: true
        rest-api-interface: 0.0.0.0
        rest-api-host-allowlist: '*'
        metrics-enabled: true
        metrics-interface: 0.0.0.0
        metrics-host-allowlist: '*'
```

* Install Eth2 deposit CLI tool and automatically setup multiple validator accounts/keys to register on the Prater testnet:
```
  - role: 0x0I.teku
    vars:
      setup_deposit_cli: true
      deposit_cli_version: v1.2.0
      setup_deposit_accounts: true
      deposit_num_validators: 3
      deposit_key_password: ABCabc123!@#$
      eth2_chain: prater
```

* Only deploy validator client and connect client to custom beacon chain node + set validator graffiti:
```
  - role: 0x0I.teku
    vars:
      target_services: ["validator']
      beacon_config:
        network: mainnet
        beacon-node-api-endpoint: http://teku.mainnet.01labs.net:5051
        validators-graffiti: O1
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
