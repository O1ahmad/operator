<p><img src="https://code.benco.io/icon-collection/logos/ansible.svg" alt="ansible logo" title="ansible" align="left" height="60" /></p>
<p><img src="https://in-trend.biz/wp-content/uploads/2017/10/nanopool.png" alt="nanopool logo" title="nanopool" align="right" height="60" /></p>

Ansible Role :lock_with_ink_pen: :link: Zecminer
=========
[![Galaxy Role](https://img.shields.io/ansible/role/46755.svg)](https://galaxy.ansible.com/0x0I/zecminer)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/0x0I/ansible-role-zecminer?color=yellow)
[![Downloads](https://img.shields.io/ansible/role/d/46755.svg?color=lightgrey)](https://galaxy.ansible.com/0x0I/zecminer)
[![Build Status](https://travis-ci.org/0x0I/ansible-role-zecminer.svg?branch=master)](https://travis-ci.org/0x0I/ansible-role-zecminer)
[![License: MIT](https://img.shields.io/badge/License-MIT-blueviolet.svg)](https://opensource.org/licenses/MIT)

**Table of Contents**
  - [Supported Platforms](#supported-platforms)
  - [Requirements](#requirements)
  - [Role Variables](#role-variables)
      - [Install](#install)
      - [Config](#config)
      - [Launch](#launch)
      - [Uninstall](#uninstall)
  - [Dependencies](#dependencies)
  - [Example Playbook](#example-playbook)
  - [License](#license)
  - [Author Information](#author-information)

Ansible role that installs and configures EWBF's Zcash Zecminer: a CUDA-based GPU miner for solving the Equihash Proof-of-Work Algorithm.

##### Supported Platforms:
```
* Redhat(CentOS/Fedora)
* Ubuntu
```

Requirements
------------
Requires the `unzip/gtar` utility to be installed on the target host. See ansible `unarchive` module [notes](https://docs.ansible.com/ansible/latest/modules/unarchive_module.html#notes) for details.

Role Variables
--------------
Variables are available and organized according to the following software & machine provisioning stages:
* _install_
* _config_
* _launch_
* _uninstall_

#### Install

`zecminer_user: <service-user-name>` (**default**: *zecminer*)
- dedicated service user and group used by `zecminer` for privilege separation (see [here](https://www.beyondtrust.com/blog/entry/how-separation-privilege-improves-security) for details)

`install_type: <archive>` (**default**: archive)
- **archive**: currently compatible with **tar** formats, installation of **Zecminer** via compressed archives results in the direct download of its component binaries, consisting of the `zecminer` mining software.

  **note:** archived installation binaries can be obtained from the official [releases](https://github.com/nanopool/ewbf-miner/releases) site or those generated from development/custom sources.

`install_dir: </path/to/installation/dir>` (**default**: `/opt/zecminer`)
- path on target host where the `zecminer` binaries should be extracted to.

`archive_url: <path-or-url-to-archive>` (**default**: see `defaults/main.yml`)
- address of a compressed **tar or zip** archive containing `zecminer` binaries. This method technically supports installation of any available version of `traefik`. Links to official versions can be found [here](https://github.com/nanopool/ewbf-miner/releases).

`archive_options: <untar-or-unzip-options>` (**default**: `[]`)
- list of additional unarchival arguments to pass to either the `tar` or `unzip` binary at runtime for customizing how the archive is extracted to the designated installation directory. See [man tar](https://linux.die.net/man/1/tar) and [man unzip](https://linux.die.net/man/1/unzip) for available options to specify, respectively.

#### Config

**Zecminer** supports specification of various options controlling aspects of the Zcash miner's behavior and operational profile. Each configuration can be expressed via either the tool's command-line interface or within in an INI-sytle configuration file. The following details the facilities provided by this role to manage the contents of the aforementioned configuration file.

In typical `INI` or `TOML` fashion, individual sets of configurations consist of definitions representing config sections and associated setting key-value pairs. These sections and settings are made up of common miner options and custom Zcash server pool properties to access.

Reference [here](https://zec.nanopool.org/) for a list of server pool connection settings and [here](https://gist.github.com/0x0I/8a02072f7a2729bd8a0ab626d89c16d2) for an example config.

`config_dir: </path/to/configuration/dir>` (**default**: `{{ install_dir }}`)
- path on target host where the `zecminer` configuration file should be rendered

Each of these configurations can be expressed using the `zecminer_config` hash, which contains a list of various `zecminer` configuration options (hash) objects organized according to the following:
* common - miner configuration options common to all server connections
* server - custom server connection and operational configuration options to the specified server

Each `zecminer_config` entry is a hash representing the equivalent of a configuration section as expected to be expressed by the `zecminer` server. As previously described, these hashes are structured by config section and associated key-value setting pairs. 

`[zecminer_config: <entry>:] name: <common|server>` (**default**: *required*)
- name of the configuration section to render

`[zecminer_config: <entry>:] settings: <YAML>` (**default**: )
- specifies parameters that manage various aspects of the Zcash miner's operations

###### Example

 ```yaml
  zecminer_config:
    - name: common
      settings:
        log: 0
        logfile: /var/log/miner.log
        api: 127.0.0.1:42000
    - name: server
      settings:
        server: zec-us-east1.nanopool.org
        port: 6666
        user: user1-key
        pass: user1-password
  ```
  
#### Launch

`extra_run_args: <zecminer-cli-options>` (**default**: `[]`)
- list of `zecminer` commandline arguments to pass to the binary at runtime for customizing launch

Supporting full expression of `zecminer`'s [cli](https://gist.github.com/0x0I/8a57be009fcdb3a006262309aadd741c) and, conserquently the full set of configuration options as referenced and described above, this variable enables the launch to be customized according to the user's exact specification.

`custom_unit_properties: <hash-of-systemd-service-settings>` (**default**: `[]`)
- hash of settings used to customize the `[Service]` unit configuration and execution environment of the `zecminer` **systemd** service.

#### Uninstall

`perform_uninstall: <true | false>` (**default**: `false`)
- whether to uninstall and remove all artifacts and remnants of this `zecminer` installation on a target host (**see**: `handlers/main.yml` for details)

Dependencies
------------

- 0x0i.systemd

Example Playbook
----------------
default example:
```
- hosts: all
  roles:
  - role: 0x0I.zecminer
```

download and install specific version of `zecminer` binaries:
```
- hosts: all
  roles:
  - role: 0x0I.zecminer
    vars:
      install_type: archive
      archive_url: https://github.com/nanopool/ewbf-miner/releases/download/v0.1.0b/Zec.miner.0.1.0b.Linux.Bin.tar.gz
```

enable debug logging for troubleshooting purposes:
```
- hosts: all
  roles:
  - role: 0x0I.zecminer
    vars:
      zecminer_config:
        - name: common
          settings:
            log: 1
            logfile: /var/log/miner.log
```

enable mining API server on custom listening port (via API command-line + config):
```
- hosts: all
  roles:
  - role: 0x0I.zecminer
    vars:
      extra_run_args:
        - --api 0.0.0.0:12345
      zecminer_config:
        - name: common
          settings:
            api: 0.0.0.0:12345
```

configure main and backup server pools for mining operations:
 ```yaml
  zecminer_config:
    # main server pool connection properties
    - name: server
      settings:
        server: zec-us-east1.nanopool.org
        port: 6666
        user: user-key
        pass: user-password
    # back server pool connection properties
    - name: server
      settings:
        server:  zec-eu1.nanopool.org
        port: 6666
        user: user-key
        pass: user-password
  ```
  
manage host resource allocation for mining operations:
```
- hosts: all
  roles:
  - role: 0x0I.zecminer
    vars:
      custom_unit_properties:
        CPUQuota: 400%
        MemoryLimit: 4GB
```

License
-------

MIT

Author Information
------------------

This role was created in 2020 by O1.IO.
