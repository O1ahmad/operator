<p><img src="https://code.benco.io/icon-collection/logos/ansible.svg" alt="ansible logo" title="ansible" align="left" height="60" /></p>
<p><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Ethereum-icon-purple.svg/1200px-Ethereum-icon-purple.svg.png" alt="ethereum logo" title="ethereum" align="right" height="100" /></p>

Ansible Role 💻 🔗 Geth
=========

Configure and operate Geth (Go-Ethereum): an Ethereum blockchain client written in Go.

Requirements
------------

[Docker SDK](https://docker-py.readthedocs.io/en/stable/) for Python (for Python 2.6 support, use the deprecated `docker-py` library instead) or installation of the `docker` engine.

Role Variables
--------------

| var | description | default |
| :---: | :---: | :---: |
| *image* | Geth service container image to deploy | `0labs/geth:latest` |
| *chain* | Ethereum network/chain to connect geth instance to | `rinkeby` |
| *config_dir* | configuration directory path within container | `/etc/geth` |
| *config_env_file* | Path to environment file to load by geth container | `/var/tmp/geth/.env` |
| *config* | dict of client configuration settings (reference [here](https://gist.github.com/0x0I/5887dae3cdf4620ca670e3b194d82cba) for examples of available options) | see `defaults/main.yml` for base/default config |
| *env_vars* | dict of client runtime environment settings (reference [here](https://github.com/0x0I/container-file-geth#operations) for examples of available options) | `{}` |
| *p2p_port* | Peer-to-peer network discovery and communication listening port | `30303` |
| *rpc_port* | HTTP-RPC server listening port | `8545` |
| *ws_port* | WS-RPC server listening port | `8546` |
| *enable_metrics_server* | Whether to activate `geth`'s built-in metrics server | `true` |
| *metrics_port* | Metrics HTTP server listening port | `6060` |
| *metrics_addr* | Enable stand-alone metrics HTTP server listening interface | `127.0.0.1` |
| *host_data_dir* | Host directory to store client runtime/operational data | `/var/tmp/geth` |
| *ops_runtime_dir* | operational directory to store runtime artifacts | `/var/tmp/geth` |
| *restart_policy* | container restart policy | `unless-stopped` |
| *exporter_image* | Geth data exporter image to deploy | `hunterlong/gethexporter:latest` |
| *exporter_rpc_addr* | Network address `ip:port` of geth rpc instance to export data from | `http://localhost:8545` |
| *exporter_port* | Exporter metrics collection listening port | `10090` |
| *target_services* | list of services to include in deployment process (`geth` and/or `geth-exporter`) | `["geth", "geth-exporter"]` |
| *setup_mode* | infrastructure provisioning and setup mode (either *container* or *systemd*) | `container` |
| *log_mode* | `geth` application logging mode/format (either *debug* or *json*) | `debug` |
| *verbosity_level* | logging verbosity | `3 (info)` |
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

* Launch an Ethereum light client and connect it to the Ropsten, best current like-for-like representation of Ethereum, PoW (Proof of Work) test network:
```
  - role: 0x0I.geth
    vars:
      chain: ropsten
      config:
        Eth:
          SyncMode: light
```

* Customize Geth deploy image and p2p port:
```
  - role: 0x0I.geth
    vars:
      image: 0labs/geth:v1.10.11
      p2p_port: 30313
```

* Run *fast* sync node with automatic daily backups of custom keystore directory:
```
  - role: 0x0I.geth
    vars:
      chain: mainnet
      config:
        Eth:
          SyncMode: fast
      env_vars:
        AUTO_BACKUP_KEYSTORE: true
        KEYSTORE_DIR: /tmp/keystore
        BACKUP_INTERVAL: "0 * * * *"
        BACKUP_PASSWORD: <secret>
```

* Enable HTTP and metrics servers and expose on all interfaces:
```
  - role: 0x0I.geth
    vars:
      enable_http_server: true
      enable_metrics_server: true
      config:
        Node:
          HTTPHost: 0.0.0.0
          WSHost: 0.0.0.0
        Metrics:
          Enabled: "true"
          HTTP: 0.0.0.0
```

* Set host data directory to load from and customize geth runtime data directory:
```
  - role: 0x0I.geth
    vars:
      host_data_dir: /my/host/data
      data_dir: /container/data
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
