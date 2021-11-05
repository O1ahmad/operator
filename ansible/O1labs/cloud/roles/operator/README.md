<p><img src="https://code.benco.io/icon-collection/logos/ansible.svg" alt="ansible logo" title="ansible" align="left" height="60" /></p>
<p><img src="https://pbs.twimg.com/profile_images/1324063968877563907/n-NYkVty.png" alt="teku logo" title="teku" align="right" height="80" /></p>

Ansible Role :eyeglasses:🔗 Operator
=========

Configure and operate Operator: an open and decentralized managed infrastructure and operations service.

Requirements
------------

[Docker SDK](https://docker-py.readthedocs.io/en/stable/) for Python (for Python 2.6 support, use the deprecated `docker-py` library instead) or installation of the `docker` and `docker-compose` tools.

Role Variables
--------------

| var | description | default |
| :---: | :---: | :---: |
| *image* | Operator service container image to deploy | `0labs/operator:latest` |

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
  - role: 0x0I.operator
    vars:
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
