<p><img src="https://code.benco.io/icon-collection/logos/ansible.svg" alt="ansible logo" title="ansible" align="left" height="60" /></p>
<p><img src="https://avatars.githubusercontent.com/u/49376577?v=4" alt="O1 logo" title="O1" align="right" height="80" /></p>

Ansible Role :eyeglasses:🔗 Operator
=========

Configure and operate Operator: an open and decentralized managed infrastructure and operations service.

Requirements
------------

[Docker SDK](https://docker-py.readthedocs.io/en/stable/) for Python (for Python 2.6 support, use the deprecated `docker-py` library instead) or installation of the `docker` engine.

Role Variables
--------------

| var | description | default |
| :---: | :---: | :---: |
| *image* | Operator service container image to deploy | `0labs/operator:latest` |
| *setup_mode* | infrastructure provisioning setup mode (either `container` or `systemd` are supported) | `container` |
| *ops_runtime_dir* | operational directory to store runtime artifacts | `/var/tmp/operator` |
| *api_host* | Operator HTTP API server listening interface | `0.0.0.0` |
| *api_port* | Operator HTTP API server listening port | `1001` |
| *enable_https* | whether to setup locally signed HTTPS secure communication | `false` |
| *enable_certbot_certs* | whether to setup HTTPS secure communication using Let's Encrypt | `false` |
| *proxy_host* | host address proxy server can reach Operator HTTP API service | `operator` |
| *http_port* | port secure proxy listens on for HTTP connections   | `80` |
| *https_port* | port secure proxy listens on for HTTPS connections | `443` |
| *cert_dir* | directory to store and retrieve HTTPS certificates | `/var/www/certbot` |
| *email* | email address to register/associate with HTTPS certificates | `none` |
| *domain_names* | domain name(s) to register/associate with HTTPS certificates | `[]` |
| *cpus* | available CPU resources each deployed component can use | `1.0` |
| *memory* | available memory resources each deployed component can use | `1g` |
| *restart_policy* | container restart policy | `unless-stopped` |
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

* Modify the operator HTTP API service image:
```
  - role: o1labs.cloud.operator
    vars:
      image: 0labs/operator:v0.1.0
```

* Launch an operator HTTP API service on a custom listening port:
```
  - role: o1labs.cloud.operator
    vars:
      api_port: 8080
```

* Enable HTTPS secure communication with locally signed certificates:
```
  - role: o1labs.cloud.operator
    vars:
      enable_https: true
```

* Enable HTTPS secure communication with Let's Encrypt signed certificates and associated certificate credentials:
```
  - role: o1labs.cloud.operator
    vars:
      enable_https: true
      enable_certbot_certs: true
      email: operator.support@example.org
      domain_names: [ "my-operator.example.net" ] # ensure DNS maps to ip-address of node being deployed to
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
