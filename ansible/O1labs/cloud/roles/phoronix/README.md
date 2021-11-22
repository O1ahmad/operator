<p><img src="https://code.benco.io/icon-collection/logos/ansible.svg" alt="ansible logo" title="ansible" align="left" height="60" /></p>
<p><img src="https://i.imgur.com/mA5dAPk.png" alt="pts logo" title="phoronix" align="right" height="60" /></p>

Ansible Role :bar_chart: :boom: Phoronix
=========
[![Galaxy Role](https://img.shields.io/ansible/role/47439.svg)](https://galaxy.ansible.com/0x0I/phoronix)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/0x0I/ansible-role-phoronix?color=yellow)
[![Downloads](https://img.shields.io/ansible/role/d/47439.svg?color=lightgrey)](https://galaxy.ansible.com/0x0I/phoronix)
[![Build Status](https://travis-ci.com/0x0I/ansible-role-phoronix.svg?branch=master)](https://travis-ci.com/0x0I/ansible-role-phoronix)
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

Ansible role that installs and configures Phoronixi-Test-Suite (PTS): a comprehensive & extensible testing and benchmarking platform for a range of hardware and machine subsystems.

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

_The following variables can be customized to control various aspects of this installation process, ranging from the package version or archive to download and install to the collection of system information and capabilites of targeted hosts:_

`install_type: <package | archive>` (**default**: archive)
- **package**: supported by Debian and Redhat distributions, package installation of *PTS* pulls the specified package from the respective package management repository.

`package_name: <package-name-and-version>` (**default**: *phoronix-test-suite*[-latest])
- name and version of the *phoronix-test-suite* package to download and install. [Reference](http://fr2.rpmfind.net/linux/rpm2html/search.php?query=phoronix&submit=Search+...&system=&arch=) or run something like `dnf --showduplicates list phoronix-test-suite` in a terminal to display a list of available packages for your platform.

  - Note that the installation directory is determined by the package management system and currently defaults to under `/usr/bin` for all distros.

- **archive**: compatible with both **tar and zip** formats, archived installation binaries can be obtained from local and remote compressed archives either from the official [releases index](https://github.com/phoronix-test-suite/phoronix-test-suite/releases) or those generated from development/custom sources.

`install_dir: </path/to/installation/dir>` (**default**: `/opt/phoronix`)
- path on target host where the `PTS` binaries should be extracted to. *ONLY* relevant when `install_type` is set to **archive**

`archive_url: <path-or-url-to-archive>` (**default**: see `defaults/main.yml`)
- address of a compressed **tar or zip** archive containing `ansible` binaries. This method technically supports installation of any available version of `phoronix-test-suite`. Links to official versions can be found [here](https://github.com/phoronix-test-suite/phoronix-test-suite/releases). *ONLY* relevant when `install_type` is set to **archive**

`inspect_system: <true | false>` (**default**: *true*)
* load *PTS* gathered system information about the target host. Information consists of:
  * general system details and diagnostic info
  * attached sensor capabilities
  * networking configuration

#### Config

...*description of configuration related vars*...

#### Launch

When operating in `autopilot` mode **ONLY**, execution of *PTS* test suites and individual or groups of tests runs is accomplished using the [systemd](https://www.freedesktop.org/wiki/Software/systemd/) service management tool. Launched as background processes or daemons subject to the configuration and execution potential provided by the underlying `systemd` *Service* management framework, each test run can be executed within an environment according to specific run requirements and/or operator specifications as well as operated in parallel or sequentially based on a defined order.

The following variables can be adjusted to manage these execution policies.

`default_run_asynchronous: <true | false>` (**default**: *false*)
- whether to run configured tests asynchronously and in parallel on a particular host **by default** or execute synchronously waiting for each test to finish prior to starting the next. *Otherwise, defer to run preference.*

`default_autopilot: <true | false>` (**default**: *false*)
- automatically execute a test/benchmarking run, from installation to results reporting, using provided operator configurations **by default**. *Otherwise, defer to run preference.*

`[user_configs: <config-entry>: test_runs: <test-entry>:] unit_properties: <hash>` (**default**: `{}`)
- hash of settings used to customize the `[Service]` unit configuration and execution environment of the `test run` **systemd** service.

###### Example

 ```yaml
  user_configs:
    - user: devops
      config:
        BatchMode:
          SaveResults: true
      test_runs:
      - name: pts/compress-gzip
        runtime_config:
          test_results_name: test-compress-results
        unit_properties:
          # Automatically restart and continue test run on failure - *note*: reuse of `test_results_name` defined above
          Restart: on-failure
          ExecReload: phoronix-test-suite finish-run test-compress-results
          
          # Run helper post execution script to convert test results to json and store in file for upload
          ExecStopPre: /usr/bin/test_post_exec.sh test-compress-results
          ExecStopPost: "aws s3 cp /opt/phoronix/test-compress-results.results.json s3://benchmark_results/"
 ```

#### Uninstall

Support for uninstalling and removing artifacts necessary for provisioning allows for users/operators to return a target host to its configured state prior to application of this role. This can be useful for recycling nodes and roles and perhaps providing more graceful/managed transitions between tooling upgrades.

_The following variable(s) can be customized to manage this uninstall process:_

`perform_uninstall: <true | false>` (**default**: `false`)
- whether to uninstall and remove all artifacts and remnants of this `phoronix-test-suite` installation on a target host (**see**: `handlers/main.yml` for details)

Dependencies
------------

0x0i.systemd

Example Playbook
----------------
default example:
```
- hosts: benchmark-nodes
  roles:
  - role: 0x0I.phoronix
```

License
-------

MIT

Author Information
------------------

This role was created in 2019 by O1.IO.
