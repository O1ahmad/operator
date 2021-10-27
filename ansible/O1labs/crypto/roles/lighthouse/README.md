<p><img src="https://code.benco.io/icon-collection/logos/ansible.svg" alt="ansible logo" title="ansible" align="left" height="60" /></p>
<p><img src="https://miro.medium.com/max/300/1*76dYSeZfdwypV1bzlwPivg.gif" alt="Lighthouse logo" title="lighthouse" align="right" height="80" /></p>

Container File ⛵ 🔗 Lighthouse
=========

Configure and operate Lighthouse: an Ethereum 2.0 client, written in Rust and maintained by Sigma Prime.

Requirements
------------

[Docker SDK](https://docker-py.readthedocs.io/en/stable/) for Python (for Python 2.6 support, use the deprecated `docker-py` library instead) or installation of the `docker` and `docker-compose` tools.

Role Variables
--------------

| var | description | default |
| :---: | :---: | :---: |
| *image* | Lighthouse client container image to deploy | `0labs/lighthouse:latest` |
| *eth2_chain* | Ethereum 2.0 chain to target during client helper operations | `prater` |
| *p2p_tcp_port* | peer-to-peer network communication and listening port | `9000` |
| *p2p_udp_port* | peer-to-peer network discovery port | `9000` |
| *beacon_api_port* | beacon node RESTful HTTP API listening port | `5052` |
| *beacon_metrics_port* | port used to listen and respond to metrics requests for prometheus | `5054` |
| *beacon_extra_args* | command-line flags and options to include within lighthouse beacon node launch processes | `<none>` |
| *validator_api_port* | validator client RESTful HTTP API listening port | `5062` |
| *validator_metrics_port* | port used to listen and respond to metrics requests for prometheus | `5064` |
| *validator_extra_args* | command-line flags and options to include within lighthouse validator client launch processes | `<none>` |
| *host_data_dir* | host directory to store node runtime/operational data | `/var/tmp/lighthouse` |
| *data_dir* | container directory to store node runtime/operational data | `/root/.lighthouse` |
| *host_wallet_dir* | host directory to store node account wallets | `/var/tmp/lighthouse/wallets` |
| *host_keys_dir* | host directory to store node account keys | `/var/tmp/lighthouse/keys` |
| *beacon_env_vars* | path to environment file to load by compose Beacon node container (see [list](https://github.com/sigp/lighthouse/issues/1876) of available config options) | `/var/tmp/lighthouse/.beacon.env` |
| *validator_env_vars* | Path to environment file to load by compose Validator container (see [list](https://github.com/sigp/lighthouse/issues/1876) of available config options) | `/var/tmp/lighthouse/.validator.env` |
| *setup_mode* | infrastructure provisioning setup mode (either `compose`, leveraging **docker-compose**, or `systemd` are supported) | `compose` |
| *target_state* | desired role deployment state (either *present* or *absent*) | `present` |
| *target_services* | list of services to include in deployment process (`lighthouse-beacon` and/or `lighthouse-validator`) | `["lighthouse-beacon", "lighthouse-validator"]` |
| *_ops_runtime_dir* | operational directory to store runtime artifacts | `/var/tmp/lighthouse` |
| *setup_deposit_cli* | whether to download the Eth 2.0 deposit CLI maintained at https://github.com/ethereum/eth2.0-deposit-cli | `false` |
| *deposit_cli_version* | version of the Eth 2.0 deposit CLI to download | `v1.2.0` |
| *setup_deposit_accounts* | whether to automatically setup Eth 2.0 validator depositor accounts ([see](https://github.com/ethereum/eth2.0-deposit-cli#step-2-create-keys-and-deposit_data-json) for more details) | `false` |
| *deposit_dir* | container directory to generate Eth 2.0 validator deposit keystores | `/var/tmp/deposit` |
| *deposit_mnemonic_lang* | language to generate deposit mnemonic in | `english` |
| *deposit_num_validators* | count of Eth 2.0 validator deposit keystores to generate | `1` |
| *deposit_key_password* | validator deposit keystore password associated with generated mnemonic | `passw0rd` |
| *setup_validator* | whether to attempt to import validator keystores and associated wallets | `false` |
| *validator_keystore_password* | password to secure validator wallet associated with imported keystore | `passw0rd` |
| *restart_policy* | container restart policy | `unless-stopped` |

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

* Launch a Lighthouse beacon-chain node connected to the Prater Ethereum 2.0 testnet using a Goerli web3 Ethereum provider:
```
  - role: 0x0I.lighthouse
    vars:
      target_services: ["lighthouse-beacon"]
      beacon_extra_args: "--network=prater --eth1-endpoints=http://ethereum-rpc.goerli.01labs.net:8545"
```

* Customize the beacon chain node deploy container image and host + container data directory:
```
  - role: 0x0I.lighthouse
    vars:
      image: 0labs/lighthouse:v2.0.1
      host_data_dir: /my/host/data
      beacon_extra_args: "--datadir=/container/data/dir"
```

* Install Eth2 deposit CLI tool and automatically setup multiple validator accounts/keys to register on the Prater testnet:
```
  - role: 0x0I.lighthouse
    vars:
      setup_deposit_cli: true
      eth2_chain: prater
      deposit_cli_version: v1.2.0
      setup_deposit_accounts: true
      deposit_num_validators: 3
      deposit_key_password: ABCabc123!@#$
```

* Import one or more EIP-2335 passwords/keys generated by the eth2-deposit-cli Python utility into a Lighthouse VC directory:
```
  - role: 0x0I.lighthouse
    vars:
      setup_validator: true
      host_keys_dir: /my/host/keys
      validator_keystore_password: p@$$w0rd
      validator_extra_args: "--validators-dir=/keys"
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
