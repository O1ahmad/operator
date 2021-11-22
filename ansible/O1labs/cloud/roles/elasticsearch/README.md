<p><img src="https://code.benco.io/icon-collection/logos/ansible.svg" alt="ansible logo" title="ansible" align="left" height="60" /></p>
<p><img src="https://seeklogo.com/images/E/elasticsearch-logo-C75C4578EC-seeklogo.com.png" alt="elasticsearch logo" title="elasticsearch" align="right" height="60" /></p>

Ansible Role :mag_right: :high_brightness: Elasticsearch
=========
[![Galaxy Role](https://img.shields.io/ansible/role/45171.svg)](https://galaxy.ansible.com/0x0I/elasticsearch)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/0x0I/ansible-role-elasticsearch?color=yellow)
[![Downloads](https://img.shields.io/ansible/role/d/45171.svg?color=lightgrey)](https://galaxy.ansible.com/0x0I/elasticsearch)
[![Build Status](https://travis-ci.org/0x0I/ansible-role-elasticsearch.svg?branch=master)](https://travis-ci.org/0x0I/ansible-role-elasticsearch)
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

Ansible role that installs and configures Elasticsearch: a real-time distributed search and analytics engine.

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
* _launch_
* _uninstall_

#### Install

`elasticsearch`can be installed using OS package management systems (e.g `apt`, `yum`) or compressed archives (`.tar`, `.zip`) downloaded and extracted from various sources.

_The following variables can be customized to control various aspects of this installation process, ranging from software version and source location of binaries to the installation directory where they are stored:_

`elasticsearch_user: <service-user-name>` (**default**: *elasticsearch*)
- dedicated service user and group used by `elasticsearch` for privilege separation (see [here](https://www.beyondtrust.com/blog/entry/how-separation-privilege-improves-security) for details)

`install_type: <package | archive>` (**default**: archive)
- **package**: supported by Debian and Redhat distributions, package installation of Elasticsearch pulls the specified package from the respective package management repository.
  - Note that the installation directory is determined by the package management system and currently defaults to `/usr/share` for both distros. Attempts to set and execute a package installation on other Linux distros will result in failure due to lack of support.
- **archive**: compatible with both **tar and zip** formats, archived installation binaries can be obtained from local and remote compressed archives either from the official [download/releases](https://www.elastic.co/downloads/elasticsearch) site or those generated from development/custom sources.

`install_dir: </path/to/installation/dir>` (**default**: `/opt/elasticsearch`)
- path on target host where the `elasticsearch` binaries should be extracted to.

`archive_url: <path-or-url-to-archive>` (**default**: see `defaults/main.yml`)
- address of a compressed **tar or zip** archive containing `elasticsearch` binaries. This method technically supports installation of any available version of `elasticsearch`. Links to official versions can be found [here](https://www.elastic.co/downloads/past-releases#elasticsearch).

`archive_checksum: <path-or-url-to-checksum>` (**default**: see `defaults/main.yml`)
- address of a checksum file for verifying the data integrity of the specified archive. While recommended and generally considered a best practice, specifying a checksum is *not required* and can be disabled by providing an empty string (`''`) for its value.

`package_url: <path-or-url-to-package>` (**default**: see `defaults/main.yml`)
- address of a **Debian or RPM** package containing `elasticsearch` source and binaries. Note that the installation layout is determined by the package management systems. Consult Elastic's official documentation for both [RPM](https://www.elastic.co/guide/en/elasticsearch/reference/current/rpm.html) and [Debian](https://www.elastic.co/guide/en/elasticsearch/reference/current/deb.html) installation details.

`package_checksum: <path-or-url-to-checksum>` (**default**: see `vars/...`)
- address of a checksum file for verifying the data integrity of the specified package. While recommended and generally considered a best practice, specifying a checksum is *not required* and can be disabled by providing an empty string (`''`) for its value.

`checksum_format: <string>` (**default**: see `sha512`)
- hash algorithm used for file verification associated with the specified archive or package checksum. Reference [here](https://en.wikipedia.org/wiki/Cryptographic_hash_function) for more information about checksums/cryptographic hashes.

#### Config

Configuration of `elasticsearch` is expressed within 3 files:
- `elasticsearch.yml` for configuring Elasticsearch
- `jvm.options` for configuring Elasticsearch JVM settings
- `log4j2.properties` for configuring Elasticsearch logging

These files are located in the config directory, which as previously mentioned, depends on whether or not the installation is from an archive distribution (tar.gz or zip) or a package distribution (Debian or RPM packages).

For additional details and to get an idea how each config should look, reference Elastic's official [configuration](https://www.elastic.co/guide/en/elasticsearch/reference/current/settings.html) documentation.

_The following variables can be customized to manage the location and content of these configuration files:_

`config_dir: </path/to/configuration/dir>` (**default**: `/opt/elasticsearch/config`)
- path on target host where the aforementioned configuration files should be stored

`managed_configs: <list of configs to manage>` (**default**: see `defaults/main.yml`)
- list of configuration files to manage with this Ansible role

  Allowed values are any combination of:
  - `elasticsearch_config`
  - `jvm_options`
  - `log4j_properties`

`config: <hash-of-elasticsearch-settings>` **default**: {}

- The configuration file should contain settings which are node-specific (such as *node.name* and *paths*), or settings which a node requires in order to be able to join a cluster.

Any configuration setting/value key-pair supported by `elasticsearch` should be expressible within the hash and properly rendered within the associated YAML config. Values can be expressed in typical _yaml/ansible_ form (e.g. Strings, numbers and true/false values should be written as is and without quotes).

  Keys of the `config` hash can be either nested or delimited by a '.':
  ```yaml
  config:
    node.name: example-node
    path:
      logs: /var/log/elasticsearch
  ```

A list of configurable settings can be found [here](https://github.com/elastic/elasticsearch/tree/master/docs/reference/modules).

`jvm_options: <list-of-dicts>` **default**: `[]`

- The preferred method of setting JVM options (including system properties and JVM flags) is via the *jvm.options* configuration file. The file consists of a line-delimited list of arguments used to modify the behavior of Elasticsearch's JVM.

While you should rarely need to change Java Virtual Machine (JVM) options; there are situations (e.g.insufficient heap size allocation) in which adjustments may be necessary. Each line to be rendered in the file can be expressed as an entry within a list of dicts, contained within `jvm_options`, consisting of a hash composed of an *optional* `comment` field and list of associated arguments to configure:

  ```yaml
  jvm_options:
    - comment: set the min and max JVM heap size (to the same value)
      arguments:
        - '-Xms1g'
        - '-Xmx1g'
  ```

  A list of available arguments can be found [here](https://docs.oracle.com/javase/8/docs/technotes/tools/windows/java.html).

`log4j_properties: <list-of-dicts>` **default**: `[]`

- Elasticsearch makes use of the Apache [log4j 2](https://logging.apache.org/log4j/2.x/) logging system for organizing and managing each of its main and sub-component logging facilities. As such, individual settings can be applied on a global or per-component basis by defining configuration settings associated with various aspects of the logging process. By default, log4j 2 loads a `log4j2.properties` file which consists of line-delimited properties expressing a key-value pair representing a desired configuration.

3 properties `${sys:es.logs.base_path}`, `${sys:es.logs.cluster_name}`, and `${sys:es.logs.node_name}` are exposed by Elasticsearch and can be referenced in the configuration file to determine the location of this log file and potentially others. The property **${sys:es.logs.base_path}** will resolve to the log directory, **${sys:es.logs.cluster_name}** will resolve to the cluster name *(used as the prefix of log filenames in the default configuration)*, and **${sys:es.logs.node_name}** will resolve to the node name *(if the node name is explicitly set)*.

Each line to be rendered in the file can be expressed as an entry within a list of dicts, contained within `log4j_properties`, consisting of a hash containing an *optional* `comment` field and list of associated key-value pairs:

  ```yaml
  log4j2_properties:
    - comment: log action execution errors for easier debugging
      settings:
        - logger.action.name: org.elasticsearch.action
          logger.action.level: debug
  ```

Reference Elastic's official [logging](https://www.elastic.co/guide/en/elasticsearch/reference/current/logging.html) documentation for more details regarding a list of available configurations and [examples](https://github.com/elastic/elasticsearch/blob/master/qa/logging-config/custom-log4j2.properties) of how this configuration should look.

`data_dir: </path/to/data/dir>` (**default**: `/var/data/elasticsearch`)
- path on target host where data generated by the Elasticsearch service (e.g. indexed records) should be stored

`logs_dir: </path/to/log/dir>` (**default**: `/var/log/elasticsearch`)
- path on target host where logs generated by the Elasticsearch service should be stored

#### Launch

Running the `elasticsearch` search and analytics service along with its API server is accomplished utilizing the [systemd](https://www.freedesktop.org/wiki/Software/systemd/) service management tool for both *package* and *archive* installations. Launched as background processes or daemons subject to the configuration and execution potential provided by the underlying management framework, launch of `elasticsearch` can be set to adhere to system administrative policies right for your environment and organization.

_The following variables can be customized to manage the service's **systemd** service unit definition and execution profile/policy:_

`extra_run_args: <elasticsearch-cli-options>` (**default**: `[]`)
- list of `elasticsearch` commandline arguments to pass to the binary at runtime for customizing launch. Supporting full expression of `elasticsearch`'s cli, this variable enables the launch to be customized according to the user's specification.

`custom_unit_properties: <hash-of-systemd-service-settings>` (**default**: `[]`)
- hash of settings used to customize the [Service] unit configuration and execution environment of the Elasticsearch **systemd** service.

```yaml
custom_unit_properties:
  Environment: "ES_HOME={{ install_dir }}"
  LimitNOFILE: infinity
```

Reference the [systemd.service](http://man7.org/linux/man-pages/man5/systemd.service.5.html) *man* page for a configuration overview and reference.

#### Uninstall

Support for uninstalling and removing artifacts necessary for provisioning allows for users/operators to return a target host to its configured state prior to application of this role. This can be useful for recycling nodes and roles and perhaps providing more graceful/managed transitions between tooling upgrades.

_The following variable(s) can be customized to manage this uninstall process:_

`perform_uninstall: <true | false>` (**default**: `false`)
- whether to uninstall and remove all artifacts and remnants of this `elasticsearch` installation on a target host (**see**: `handlers/main.yml` for details)


Dependencies
------------

- 0x0i.systemd

Example Playbook
----------------
default example:
```
- hosts: all
  roles:
  - role: 0x0I.elasticsearch
```

install specific version of OS distribution native package with pre-defined defaults:
```
- hosts: legacy-ES-cluster
  roles:
  - role: 0x0I.elasticsearch
    vars:
        managed_configs: []
        install_type: package
        package_url: https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/rpm/elasticsearch/2.0.0/elasticsearch-2.0.0.rpm
        package_checksum: https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/rpm/elasticsearch/2.0.0/elasticsearch-2.0.0.rpm.sha1
        checksum_format: sha1
```

provision hybrid master/data node with customized data and logging directories:
```
- hosts: test-elasticsearch
  roles:
    - role: 0x0I.elasticsearch
      vars:
        managed_configs: ['elasticsearch_config']
        config:
          cluster.name: example-cluster
          node.master: true
          node.data: true
          path:
            data: /mnt/data/elasticsearch
            logs: /mnt/logs/elasticsearch
```

adjust JVM heap settings and enable verbose logging for cluster debugging/troubleshooting:
```
- hosts: elasticsearch
  roles:
    - role: 0x0I.elasticsearch
      vars:
        managed_configs: ['jvm_options', 'log4j2_properties']
        jvm_options:
          - comment: adjust the min and max JVM heap size to handle increased output
            arguments:
              - '-Xms16g'
              - '-Xmx16g'
        log4j2_properties:
          - comment: log action execution errors for easier debugging
            settings:
              - logger.action.name: org.elasticsearch.action
                logger.action.level: debug
        extra_run_args:
          - '--verbose'
```

License
-------

MIT

Author Information
------------------

This role was created in 2019 by O1.IO.
