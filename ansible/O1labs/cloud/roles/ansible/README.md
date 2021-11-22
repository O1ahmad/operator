<p><img src="https://code.benco.io/icon-collection/logos/ansible.svg" alt="ansible logo" title="ansible" align="right" height="60" /></p>

Ansible Role :construction: :nut_and_bolt: Ansible
=========
[![Galaxy Role](https://img.shields.io/ansible/role/45433.svg)](https://galaxy.ansible.com/0x0I/ansible)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/0x0I/ansible-role-ansible?color=yellow)
[![Downloads](https://img.shields.io/ansible/role/d/45433.svg?color=lightgrey)](https://galaxy.ansible.com/0x0I/ansible)
[![Build Status](https://travis-ci.org/0x0I/ansible-role-ansible.svg?branch=master)](https://travis-ci.org/0x0I/ansible-role-ansible)
[![License: MIT](https://img.shields.io/badge/License-MIT-blueviolet.svg)](https://opensource.org/licenses/MIT)

**Table of Contents**
  - [Supported Platforms](#supported-platforms)
  - [Requirements](#requirements)
  - [Role Variables](#role-variables)
      - [Install](#install)
      - [Config](#config)
      - [Uninstall](#uninstall)
  - [Dependencies](#dependencies)
  - [Example Playbook](#example-playbook)
  - [License](#license)
  - [Author Information](#author-information)

Ansible role that installs and configures an Ansible controller: a software provisioning, configuration management and application-deployment tool.

##### Supported Platforms:
```
* Debian
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
* uninstall

#### Install

`ansible`can be installed using OS package management systems (e.g. `apt`, `yum`) or compressed archives (`.tar`, `.zip`) downloaded and extracted from various sources.

_The following variables can be customized to control various aspects of this installation process, ranging from software version and source location of binaries to the installation directory where they are stored:_

`controller_user: <service-user-name>` (**default**: *ansible*)
- dedicated service user and group used by `ansible` for privilege separation (see [here](https://www.beyondtrust.com/blog/entry/how-separation-privilege-improves-security) for details)

`package_name: <package-name-and-version>` (**default**: *ansible*[-latest])
- name and version of the ansible package to download and install. [Reference](http://fr2.rpmfind.net/linux/rpm2html/search.php?query=ansible&submit=Search+...&system=&arch=) or run something like `dnf --showduplicates list ansible` in a terminal to display a list of available packages for your platform. *ONLY* relevant when `install_type` is set to **package**

`install_type: <package | archive>` (**default**: archive)
- **package**: supported by Debian and Redhat distributions, package installation of Ansible pulls the specified package from the respective package management repository.

  - Note that the installation directory is determined by the package management system and currently defaults to under `/usr/{bin,lib, share}` for both distros.

- **archive**: compatible with both **tar and zip** formats, archived installation binaries can be obtained from local and remote compressed archives either from the official [releases index](https://releases.ansible.com/ansible/?extIdCarryOver=true&sc_cid=701f2000001OH7YAAW) or those generated from development/custom sources.

`install_dir: </path/to/installation/dir>` (**default**: `/opt/ansible`)
- path on target host where the `ansible` binaries should be extracted to. *ONLY* relevant when `install_type` is set to **archive**

`archive_url: <path-or-url-to-archive>` (**default**: see `defaults/main.yml`)
- address of a compressed **tar or zip** archive containing `ansible` binaries. This method technically supports installation of any available version of `ansible`. Links to official versions can be found [here](https://github.com/ansible/ansible/releases). *ONLY* relevant when `install_type` is set to **archive**

`archive_checksum: <path-or-url-to-checksum>` (**default**: see `defaults/main.yml`)
- address of a checksum file for verifying the data integrity of the specified archive. While recommended and generally considered a best practice, specifying a checksum is *not required* and can be disabled by providing an empty string (`''`) for its value. *ONLY* relevant when `install_type` is set to **archive**.

`checksum_format: <string>` (**default**: see `sha512`)
- hash algorithm used for file verification associated with the specified archive or package checksum. Reference [here](https://en.wikipedia.org/wiki/Cryptographic_hash_function) for more information about checksums/cryptographic hashes.

`galaxy_roles: <list-of-roles>` (**default**: `[]`)
- indicates collection of roles to install from either the Ansible Galaxy community repository or custom sources.

`galaxy_collections: <list-of-collections>` (**default**: `[]`)
- indicates list of collections to install from either the Ansible Galaxy community repository or custom sources.

#### Config

Configuration of the `ansible` controller can be expressed in a config file named `ansible.cfg` written in TOML or [INI](https://www.techopedia.com/definition/24302/ini-file), a minimal markup language. Customary with INI configurations, each section represents a set of configuration options for various aspects of the Ansible controller's behavior. See [here](https://docs.ansible.com/ansible/latest/reference_appendices/config.html#ansible-configuration-settings) for a list of available configuration options and an example config [here](https://github.com/ansible/ansible/blob/devel/examples/ansible.cfg) for reference.

**Note:** This file can be found under the directory specified by the `ANSIBLE_CONFIG` environment variable or in predefined locations loaded according to a set precedence order (as managed by the `config_dir` variable defined below).

_The following variables can be customized to manage the content of this INI configuration:_

`config_dir: </path/to/configuration/dir>` (**default**: `/etc/ansible`)
- path on target host where the aforementioned INI configuration file should be stored

`config: {"<config-section>": {"<section-setting>": "<setting-value>",..},..}` **default**: see `defaults/main.yml`

* Any configuration setting/value key-pair supported by `ansible` should be expressible within the `config` hash and properly rendered within the associated INI config. Values can be expressed in typical _yaml/ansible_ form (e.g. Strings, numbers and true/false values should be written as is and without quotes).

  Furthermore, configuration is not constrained by hardcoded author defined defaults or limited by pre-baked templating. If the config section, setting and value are recognized by the `ansible` tool, :thumbsup: to define within `config`.

  Keys of the `config` hash represent INI config sections:
  ```yaml
  config:
    # [INI Section 'defaults']
    defaults: {}
  ```

  Values of `config[<key>]` represent key,value pairs within an embedded hash expressing config settings:
  ```yaml
  config:
    # INI Section '[defaults]'
    defaults:
      # Section setting inventory with value of inventory host sources directory
      inventory = /var/data/ansible/inventory
  ```

#### Uninstall

Remove both package and archive installations as well as managed Ansible configs returning the target host to its configured state prior to application of this role (e.g. can be useful for recycling configuration settings during system upgrades).

_The following variable(s) can be customized to manage this uninstall process:_

`perform_uninstall: <true | false>` (**default**: `false`)
- whether to uninstall managed Ansible installations and configurations on a target host (**see**: `handlers/main.yml` for details)

Dependencies
------------

None

Example Playbook
----------------
default example:
```
- hosts: all
  roles:
  - role: 0x0I.ansible
```

install `ansible` from specified *archive* latest version:
```
- hosts: controller
  roles:
  - role: 0x0I.ansible
    vars:
      install_type: archive
      archive_url: https://releases.ansible.com/ansible/ansible-2.9.4.tar.gz
      archive_checksum: 2517bf4743d52f00d509396a41e9ce44e5bc1285bd7aa53dfe28ea02fc1a75a6
```

change configuration directory from default and alter path to store/search for roles:
```
- hosts: controller
  roles:
  - role: 0x0I.ansible
    vars:
      config_dir: /path/to/config/dir
      config:
        defaults:
          roles_path: /mnt/ansible/roles
```

alter log path and debug output for troubleshooting/debugging purposes:
```
- hosts: controller
  roles:
  - role: 0x0I.ansible
    vars:
      config:
        defaults:
           log_path: /mnt/log/ansible/debug.log
           debug: True
```

install a set of roles and collections by default:
```
- hosts: controller
  roles:
  - role: 0x0I.ansible
    vars:
      galaxy_roles:
        - 0x0I.systemd
      galaxy_collections:
        - newswangerd.collection_demo
```

License
-------

MIT

Author Information
------------------

This role was created in 2019 by O1.IO.
