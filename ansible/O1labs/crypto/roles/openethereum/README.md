<p><img src="https://code.benco.io/icon-collection/logos/ansible.svg" alt="ansible logo" title="ansible" align="left" height="60" /></p>
<p><img src="https://openethereum.github.io/images/logo-openethereum.svg" alt="OpenEthereum logo" title="open-ethereum" align="right" height="80" /></p>

Ansible Role 💻 🔗 OpenEthereum
=========

Configure and operate OpenEthereum: a fast and feature-rich multi-network Ethereum client.

Requirements
------------

[Docker SDK](https://docker-py.readthedocs.io/en/stable/) for Python (for Python 2.6 support, use the deprecated `docker-py` library instead) or installation of the `docker` and `docker-compose` tools.

Role Variables
--------------

| var | description | default |
| :---: | :---: | :---: |
| *image* | OpenEthereum service container image to deploy | `0labs/openethereum:latest` |
| *target_state* | desired role deployment state (either *present* or *absent*) | `present` |
| *target_services* | list of services to include in deployment process (`openethereum` and/or `openethereum-exporter`) | `["openethereum", "openethereum-exporter"]` |
| *chain* | Ethereum network/chain to connect openethereum instance to | `kovan` |
| *config_dir* | configuration directory path within container | `/etc/openethereum` |
| *config* | dict of client configuration settings (reference [here](https://github.com/openethereum/openethereum/tree/main/bin/oe/cli) for examples of available options/presets) | see *defaults/main.yml* for base/default config |
| *env_vars* | dict of client runtime environment settings (reference [here](https://github.com/0x0I/container-file-openethereum#operations) for available options) | `{}` |
| *p2p_port* | Peer-to-peer network discovery and communication listening port | `30303` |
| *rpc_port* | HTTP-RPC server listening portport | `8545` |
| *ws_port* | WS-RPC server listening port | `8546` |
| *metrics_port* | Metrics HTTP server listening port | `3000` |
| *config_env_file* | Path to environment file to load by compose OpenEthereum container | `/var/tmp/openethereum/.env` |
| *host_data_dir* | Host directory to store client runtime/operational data | `/var/tmp/openethereum` |
| *data_dir* | data directory within container to store client runtime/operational data | `/data/openethereum` |
| *ops_runtime_dir* | operational directory to store runtime artifacts | `/var/tmp/openethereum` |
| *restart_policy* | container restart policy | `unless-stopped` |
| *warp_barrier* | When warp enabled never attempt regular sync before warping to block NUM | `10000` |
| *exporter_image* | OpenEthereum data exporter image to deploy | `hunterlong/gethexporter:latest` |
| *exporter_rpc_addr* | Network address `ip:port` of openethereum rpc instance to export data from | `http://localhost:8545` |
| *exporter_port* | Exporter metrics collection listening port | `10090` |

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

* Launch an Ethereum archive node and connect it to the Goerli PoS (Proof of Stake) test network:
```
  - role: 0x0I.openethereum
    vars:
      chain: goerli
      config:
        footprint:
          pruning: archive
```

* Customize OpenEthereum deploy image and p2p port
```
  - role: 0x0I.openethereum
    vars:
      image: 0labs/openethereum:v3.2.6
      p2p_port: 30313
```

* Run *warp* sync with automatic daily backups of custom keystore directory on kovan testnet:
```
  - role: 0x0I.openethereum
    vars:
      chain: kovan
      warp_barrier: 27183279
      host_data_dir: /home/user/openethereum
      data_dir: /tmp/openethereum
      config:
        network:
          warp: true
```

* Expose OpenEthereum network components on *ALL* interfaces:
```
  - role: 0x0I.openethereum
    vars:
      config:
        network:
          nat: any
        rpc:
          interface: all
        websockets:
          interface: all
        metrics:
          interface: all
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
