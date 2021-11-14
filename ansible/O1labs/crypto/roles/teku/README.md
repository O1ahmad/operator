<p><img src="https://code.benco.io/icon-collection/logos/ansible.svg" alt="ansible logo" title="ansible" align="left" height="60" /></p>
<p><img src="https://pbs.twimg.com/profile_images/1324063968877563907/n-NYkVty.png" alt="teku logo" title="teku" align="right" height="80" /></p>

Ansible Role 🔰🔗 Teku
=========

Configure and operate Teku: an open-source Ethereum 2.0 client written in Java.

Requirements
------------

[Docker SDK](https://docker-py.readthedocs.io/en/stable/) for Python (for Python 2.6 support, use the deprecated `docker-py` library instead) or installation of the `docker` engine.

Role Variables
--------------

| var | description | default |
| :---: | :---: | :---: |
| *image* | Teku client container image to deploy | `0labs/teku:latest` |
| *teku_config_dir* | configuration directory path within container | `/etc/teku` |
| *eth1_endpoints* | Comma-separated list of JSON-RPC URLs of Ethereum 1.0 nodes | `http://ethereum-rpc.goerli.01labs.net` |
| *p2p_tcp_port* | peer-to-peer network communication and listening port | `9000` |
| *p2p_udp_port* | peer-to-peer network discovery port | `9000` |
| *beacon_api_port* | HTTP API port exposed by a beacon node | `5051` |
| *beacon_metrics_port* | port used to listen and respond to metrics requests for prometheus | `8008` |
| *validator_metrics_port* | port used to listen and respond to metrics requests for prometheus | `8009` |
| *host_data_dir* | host directory to store node runtime/operational data | `/var/tmp/teku` |
| *data_dir* | container directory to store node runtime/operational data | `/data` |
| *host_wallet_dir* | host directory to store node account wallets | `/var/tmp/teku/wallets` |
| *host_keys_dir* | host directory to store node account keys | `/var/tmp/teku/keys` |
| *beacon_env_file* | path to environment file to load by the Beacon node container | `.beacon.env` |
| *beacon_env_vars* | dict of beacon node client runtime environment settings (reference [here](https://github.com/0x0I/container-file-teku#operations) for examples of available options) | `{}` |
| *validator_env_file* | Path to environment file to load by the Validator container | `.validator.env` |
| *validator_env_vars* | dict of validator client runtime environment settings (reference [here](https://github.com/0x0I/container-file-teku#operations) for examples of available options) | `{}` |
| *setup_mode* | infrastructure provisioning setup mode (either `container` or `systemd` are supported) | `container` |
| *target_services* | list of services to include in deployment process (`beacon-node` and/or `validator`) | `["beacon-node", "validator"]` |
| *ops_runtime_dir* | operational directory to store runtime artifacts | `/var/tmp/teku` |
| *beacon_config* | beacon chain node configuration options settings (see [list](https://docs.teku.consensys.net/en/latest/Reference/CLI/CLI-Syntax/) of available config options) | `{}` **note:** reference `defaults/main.yml` |
| *validator_config* | validator client configuration options settings (see [list](https://docs.teku.consensys.net/en/latest/Reference/CLI/Subcommands/Validator-Client/) of available config options | `{}` **note:** reference `defaults/main.yml` |
| *cpus* | available CPU resources each deployed component can use | `1.0` |
| *memory* | available memory resources each deployed component can use | `4g` |
| *uninstall* | whether to remove installed components and artifacts | `false` |

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
  - role: o1labs.crypto.teku
    vars:
      eth1_endpoints: http://ethereum-rpc.goerli.01labs.net:8545
      beacon_config:
        network: pyrmont
```

* Customize the deploy container image and host + container node data directory:
```
  - role: o1labs.crypto.teku
    vars:
      image: 0labs/teku:v21.10.1
      host_data_dir=/my/host/data
      beacon_config:
        data-path: /container/data/dir
```

* Enable and expose beacon node HTTP API and metrics server on all interfaces:
```
  - role: o1labs.crypto.teku
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
  - role: o1labs.crypto.teku
    vars:
      beacon_env_vars:
        SETUP_DEPOSIT_CLI: true
        DEPOSIT_CLI_VERSION: v1.2.0
        SETUP_DEPOSIT_ACCOUNTS: true
        DEPOSIT_NUM_VALIDAtORS: 3
        DEPOST_KEY_PASSWORD: ABCabc123!@#$
        ETH2_CHAIN: prater
```

* Only deploy validator client and connect client to custom beacon chain node + set validator graffiti:
```
  - role: o1labs.crypto.teku
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
