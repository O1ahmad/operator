<!-- @format -->

<p><img src="https://code.benco.io/icon-collection/logos/ansible.svg" alt="ansible logo" title="ansible" align="left" height="60" /></p>

# Ansible Role 🔗 Base-Service

Configure and operate a base service: running anything from cypto blockchain clients to the vast list of cloud-native services

## Requirements

[Docker SDK](https://docker-py.readthedocs.io/en/stable/) for Python (for Python 2.6 support, use the deprecated `docker-py` library instead) or installation of the `docker` engine.

## Role Variables

|       var       |                        description                         |     default      |
| :-------------: | :--------------------------------------------------------: | :--------------: |
|   _setupMode_   |           infrastructure provisioning setup mode           |   `container`    |
|     _name_      |                 name of service to deploy                  |    `required`    |
|     _image_     |             service container image to deploy              |    `required`    |
|    _config_     |  configuration files associated with the service to mount  |       `{}`       |
|   _configEnv_   |  environment variables to set within the service runtime   |       `{}`       |
|     _ports_     |          listening port information for a service          |       `{}`       |
|  _hostDataDir_  |   host directory to store node runtime/operational data    |    `/var/tmp`    |
|    _dataDir_    | container directory to store node runtime/operational data |      `/tmp`      |
|    _workDir_    |      operational directory to store runtime artifacts      |    `/var/tmp`    |
| _restartPolicy_ |                  container restart policy                  | `unless-stopped` |
|     _cpus_      |  available CPU resources each deployed component can use   |      `1.0`       |
|    _memory_     | available memory resources each deployed component can use |       `4g`       |
|   _uninstall_   |    whether to remove installed components and artifacts    |     `false`      |

## Dependencies

```
collections:
- name: community.docker
```

## Example Playbook

```
- hosts: servers
  roles:
```

- Launch a container that sleeps for infinity:

```
  - role: o1labs.cloud.base-service
    vars:
      name: sleepy-service
      image: busybox:latest
      command: ["sleep", "infinity"]
```

## License

MIT

## Author Information

This Ansible role was created in 2023 by O1.IO.

🏆 **always happy to help & donations are always welcome** 💸

- **ETH (Ethereum):** 0x652eD9d222eeA1Ad843efec01E60C29bF2CF6E4c

- **BTC (Bitcoin):** 3E8gMxwEnfAAWbvjoPVqSz6DvPfwQ1q8Jn

- **ATOM (Cosmos):** cosmos19vmcf5t68w6ug45mrwjyauh4ey99u9htrgqv09
