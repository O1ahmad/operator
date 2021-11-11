<p><img src="https://code.benco.io/icon-collection/logos/ansible.svg" alt="ansible logo" title="ansible" align="left" height="60" /></p>
<p><img src="https://avatars.githubusercontent.com/u/49376577?v=4" alt="O1 logo" title="O1" align="right" height="80" /></p>

Ansible Role :anchor: Base
=========

Apply basic setup of system services supporting cloud-native infrastructure.

Requirements
------------

`None`

Role Variables
--------------

| var | description | default |
| :---: | :---: | :---: |
| *install_docker* | install docker/containerization tooling | `true` |
| *harden_ssh_access* | apply SSH access security best practices | `true` |
| *install_fail2ban* | install the `fail2ban` intrusion prevention service | `true` |
| *auto_update* | enable unattended, automatic system updates | `true` |
| *docker_users* | list of additional users to add to *docker* system group | `[]` |
| *user_packages* | list of additional system packages to install | `[]` |

Dependencies
------------
```
roles:
- name: 0x0i.openssh
```
Example Playbook
----------------
```
- hosts: servers
  roles:
```

* Enable automatic, unattended system updates:
```
  - role: 0x0I.base
    vars:
      auto_update: true
```

* Apply hardened, best-practice SSH configuration and install the Fail2ban intrusion prevention service
```
  - role: 0x0I.base
    vars:
      harden_ssh_access: true
      install_fail2ban: true
```

* Install docker/containerization tooling and add additional users to `docker` system group:
```
  - role: 0x0I.base
    vars:
      install_docker: true
      docker_users: ['user_a', 'user_b']
```

* Install additional system packages:
```
  - role: 0x0I.base
    vars:
      user_packages: ['curl', 'htop']
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
