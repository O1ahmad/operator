<p><img src="https://code.benco.io/icon-collection/logos/ansible.svg" alt="ansible logo" title="ansible" align="left" height="60" /></p>
<p><img src="https://www.servethehome.com/wp-content/uploads/2017/11/Redhat-logo.jpg" alt="redhat logo" title="redhat" align="right" height="60" /></p>

Ansible Role :signal_strength: :page_with_curl: Journald
=========
[![Galaxy Role](https://img.shields.io/ansible/role/45121.svg)](https://galaxy.ansible.com/0x0I/journald)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/0x0I/ansible-role-journald?color=yellow)
[![Downloads](https://img.shields.io/ansible/role/d/45121.svg?color=lightgrey)](https://galaxy.ansible.com/0x0I/journald)
[![Build Status](https://travis-ci.org/0x0I/ansible-role-journald.svg?branch=master)](https://travis-ci.org/0x0I/ansible-role-journald)
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

Ansible role that installs and configures Journald: a system service which collects and stores logging data.

##### Supported Platforms:
```
* Debian
* Redhat(CentOS/Fedora)
* Ubuntu
```

Requirements
------------

Considered the default logging system for Linux distributions and viewed as the sucessor to `syslog` with respect to system logging services, `journald` is generally installed alongside `systemd` and available without manual or user installation on the supported list of Linux platforms.

Reference the *systemd* [README](https://github.com/systemd/systemd/blob/master/README) and journald [documentation](http://man7.org/linux/man-pages/man8/systemd-journald.8.html) for further details.

Role Variables
--------------
Variables are available and organized according to the following software & machine provisioning stages:
* _install_
* _config_
* _uninstall_

#### Install

The following variables can be customized to control certain aspects involved with the journald installation process. It is assumed that the host has a working version of the systemd package. Available versions based on OS distribution can be found [here](http://fr2.rpmfind.net/linux/rpm2html/search.php?query=systemd&submit=Search+...&system=&arch=) for reference.

`journal_group_adds: <list-of-accounts>` (**default**: `[]`)
- indicates user accounts to automatically add to the *systemd-journal* group for privileged log monitoring capabilities

*Journal files are, by default, owned and readable by the *systemd-journal* system group but are not writable. Adding a user to this group thus enables her/him to read the journal files without privilege escalation. Reference this [systemd-journald](http://man7.org/linux/man-pages/man8/systemd-journald.8.html) service documentation for more details.*

##### Example

 ```yaml
  journal_group_adds:
    - user-account-1
    - user-account-2
```

#### Config

Configuration of `journald` is declared in an [ini-style](https://en.wikipedia.org/wiki/INI_file) config file, stored as ***journald.conf*** by default. This *INI* config is composed of a single section, `[Journal]`, which may be composed of various options for declaring the desired behavior of the logging service.

These configurations can be expressed within the role's `journald_config` hash variable as lists of dicts containing key-value pairs representing the name, load path and a combination of the aforemented section options. See [here](http://man7.org/linux/man-pages/man5/journald.conf.5.html) for a complete list of available options.

`[journald_configs: <list-entry>:] name: <string>` (**default**: *journald.conf*)
- name of the journald configuration file

`[journald_configs: <list-entry>:] path: <string>` (**default**: */etc/systemd/*)
- load path of the journald configuration file

When packages or local administrators need to customize the base or default configuration, they can install configuration snippets in one of the following override directories:

| Configuration Load Path | Description |
| --- | --- |
| /etc/systemd/journald.conf | default/base configuration, as defined by the local system administrator |
| /etc/systemd/journald.conf.d/*.conf | local administrator override directory (filename is an arbitrary value) |
| /run/systemd/journald.conf.d/*.conf | runtime override directory (filename is an arbitrary value) |
| /usr/lib/systemd/journald.conf.d/*.conf | vendor package override directory |

*The main configuration file is read before any of the configuration directories, and has the lowest precedence. Entries in a file in any configuration directory override entries in the single configuration file. Files in the \*.conf.d/ configuration subdirectories are sorted and loaded by their filename in lexicographic order, regardless of which of the subdirectories they reside in.*

`[journald_config: <list-entry>:] config: <dict>` (**default**: {})
- section definitions for journal configuration

Any configuration setting/value key-pair supported by `journald` should be expressible within each `journald_configs` list entry and properly rendered within the specified *INI* config.

##### Example

 ```yaml
  journald_configs:
    - name: debug-overrides.conf
      path: /run/systemd/journald.conf.d
      config:
        MaxLevelStore: debug
        Storage: volatile
        RateLimitIntervalSec: 0
        RateLimitBurst: 0
```

#### Uninstall

Remove managed journald.conf config, returning the target host to its configured state prior to application of this role (e.g. can be useful for recycling configuration settings during system upgrades).

_The following variable(s) can be customized to manage this uninstall process:_

`perform_uninstall: <true | false>` (**default**: `false`)
- whether to uninstall managed configuration of a system's journald.conf configuration on a target host (**see**: `handlers/main.yml` for details)

Dependencies
------------

None

Example Playbook
----------------
default example:
```
- hosts: all
  roles:
  - role: 0x0I.journald
```

set persistent log storage and update/decrease persistence sync interval:
```
- hosts: staging
  roles:
  - role: 0x0I.journald
    vars:
      journald_configs:
        - config:
            Storage: persistence
            SyncIntervalSec: 10
```

create base custom configuration with debug override configuration in place:
```
- hosts: all
  roles:
  - role: 0x0I.journald
    vars:
      journald_configs:
          # base configuration will be installed at /etc/systemd/journald.conf
          - config:
              Storage: auto
              MaxLevelStore: warning
          # override configuration will be installed at /run/systemd/journald.conf.d/debug-overrides.conf
          - name: debug-overrides.conf
            path: /run/systemd/journald.conf.d
            config:
              Storage: volatile
              MaxLevelStore: debug
              RateLimitIntervalSec: 0
              RateLimitBurst: 0
```

add a set of users to the `systemd-journal` group for privileged journal access:
```
- hosts: prod
  roles:
  - role: 0x0I.journald
    vars:
      journal_group_adds: ['sysadmin-user', 'sre-user']
```

License
-------

MIT

Author Information
------------------

This role was created in 2019 by O1.IO.
