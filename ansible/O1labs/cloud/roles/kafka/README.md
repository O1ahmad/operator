<p><img src="https://code.benco.io/icon-collection/logos/ansible.svg" alt="ansible logo" title="ansible" align="left" height="60" /></p>
<p><img src="https://pbs.twimg.com/profile_images/781633389577195521/kazUJooF_400x400.jpg" alt="kafka logo" title="kafka" align="right" height="80" /></p>

Ansible Role :signal_strength: :sunrise: Kafka
=========
[![Galaxy Role](https://img.shields.io/ansible/role/47247.svg)](https://galaxy.ansible.com/0x0I/kafka)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/0x0I/ansible-role-kafka?color=yellow)
[![Downloads](https://img.shields.io/ansible/role/d/47247.svg?color=lightgrey)](https://galaxy.ansible.com/0x0I/kafka)
[![Build Status](https://travis-ci.org/0x0I/ansible-role-kafka.svg?branch=master)](https://travis-ci.org/0x0I/ansible-role-kafka)
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

Ansible role that installs and configures Kafka: a distributed and fault tolerant stream-processing service.

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

`kafka`can be installed using compressed archives (`.tar`, `.zip`) downloaded and extracted from various sources.

_The following variables can be customized to control various aspects of this installation process, ranging from software version and source location of binaries to the installation directory where they are stored:_

`kafka_user: <service-user-name>` (**default**: *kafka*)
- dedicated service user and group used by `kafka` for privilege separation (see [here](https://www.beyondtrust.com/blog/entry/how-separation-privilege-improves-security) for details)

`install_type: <string (*currently ONLY -archive- is supported)*>` (**default**: archive)
- **archive**: compatible with both **tar and zip** formats, archived installation binaries can be obtained from local and remote compressed archives either from the official [download/releases](https://kafka.apache.org/downloads) site or those generated from development/custom sources.

`kafka_home: </path/to/dir>` (**default**: `/opt/kafka`)
- path on target host where the `kafka` binaries should be extracted to and configuration rendered.

`archive_url: <path-or-url-to-archive>` (**default**: see `defaults/main.yml`)
- address of a compressed **tar or zip** archive containing `kafka` binaries. This method technically supports installation of any available version of `kafka`. Links to official versions can be found [here](https://kafka.apache.org/downloads).

#### Config

Configuration of `kafka` is expressed within 3 files:
- `server.properties` for configuring operational behavior of a Kafka broker
- `jvm.options` for configuring Kafka JVM settings
- `log4j.properties` for configuring Kafka logging

These files are located in a config directory, based on the location set for `kafka_home`.

For additional details and to get an idea how each config should look, reference Kafka's official [configuration](https://kafka.apache.org/documentation/#configuration) documentation.

_The following variables can be customized to manage the location and content of these configuration files:_

`managed_configs: <list of configs to manage>` (**default**: see `defaults/main.yml`)
- list of configuration files to manage with this Ansible role

  Allowed values are any combination of:
  - `server_properties`
  - `jvm_options`
  - `log4j_properties`

`server_properties: <hash-of-kafka-properties>` **default**: {}

* Any configuration setting/value key-pair supported by `kafka` **broker configs** should be expressible within each hash entry and properly rendered within the associated properties file. **Note:** Each `<key>` along with its `<value>` specifications should be written as expected to be rendered within the associated *properties* config (**e.g.** `zookeeper.connect: zk1.cluster.net:2121` or  `advertised.listeners: PLAINTEXT://kafka1.cluster.net:9092`).

##### Example

  ```yaml
  server_properties:
    broker.id: 10
    advertised.host.name: example-broker
  ```

A list of configurable settings can be found [here](https://kafka.apache.org/documentation/#brokerconfigs).

`jvm_options: <list-of-dicts>` **default**: `[]`

- Kafka uses a set of environment variables to manage various aspects of its Java environment - see [here](http://kafka.apache.org/documentation.html#java) for more details.

This role exposes management of these environment variables via a *jvm.options* configuration file located in the aforementioned configuration directory under `kafka_home`. The file consists of a line-delimited list of environment variable settings used to modify the behavior of Kafka's JVM.

While you should rarely need to change Java Virtual Machine (JVM) options; there are situations (e.g.insufficient heap size allocation) in which adjustments may be necessary. Each environment variable to be rendered in the file can be expressed as an entry in the `jvm_options` hash, with a list of dicts as values representing various supported flags/options.

**Note:** The hash keys representing the environment variables responsible for JVM management are not case-sensitive and can be expressed however feels comfortable to the operator.  

##### Example

  ```yaml
  jvm_options:
    kafka_heap_opts:
      - "-Xmx1g -Xms1g"
    KAFKA_JVM_PERFORMANCE_OPTS:
      - -server
      - -XX:+UseConcMarkSweepGC
      - -Djava.awt.headless=true
    KAFKA_jmx_OPTS:
      - -Dcom.sun.management.jmxremote=true
  ```

 Additional reference can be found [here](https://github.com/apache/kafka/blob/trunk/bin/kafka-run-class.sh#L184).

`log4j_properties: <list-of-dicts>` **default**: `[]`

- Kafka makes use of the Apache [log4j](https://logging.apache.org/log4j/2.x/) logging system for organizing and managing each of its main and sub-component logging facilities. As such, individual settings can be applied on a global or per-component basis by defining configuration settings associated with various aspects of the logging process. 

By default, log4j loads a `log4j.properties` file, underneath Kafka's main `{{ kafka_home }}/config` directory, which consists of line-delimited properties expressing a key-value pair representing a desired configuration.

Each line to be rendered in the file can be expressed as an entry within a list of dicts, contained within `log4j_properties`, consisting of a hash containing an *optional* `comment` field and list of associated key-value pairs encapsulated under a `settings` key root:

  ```yaml
  log4j2_properties:
    - comment: Set root logger list
      settings:
        - log4j.rootLogger: INFO,stdout,kafkaAppender
    - comment: Define stdout logger appender
      settings:
        - log4j.appender.stdout: org.apache.log4j.ConsoleAppender
        - log4j.appender.stdout.layout: org.apache.log4j.PatternLayout
  ```

See [here](https://github.com/apache/kafka/blob/trunk/config/log4j.properties) for an example configuration file and list of supported settings.

#### Launch

Running a `kafka` broker is accomplished utilizing the [systemd](https://www.freedesktop.org/wiki/Software/systemd/) service management tool for *archive* installations. Launched as background processes or daemons subject to the configuration and execution potential provided by the underlying management framework, launch of `kafka` can be set to adhere to system administrative policies right for your environment and organization.

_The following variables can be customized to manage the service's **systemd** service unit definition and execution profile/policy:_

`custom_unit_properties: <hash-of-systemd-service-settings>` (**default**: `[]`)
- hash of settings used to customize the [Service] unit configuration and execution environment of the Kafka **systemd** service.

```yaml
custom_unit_properties:
  LimitNOFILE: infinity
```

Reference the [systemd.service](http://man7.org/linux/man-pages/man5/systemd.service.5.html) *man* page for a configuration overview and reference.

#### Uninstall

Support for uninstalling and removing artifacts necessary for provisioning allows for users/operators to return a target host to its configured state prior to application of this role. This can be useful for recycling nodes and roles and perhaps providing more graceful/managed transitions between tooling upgrades.

_The following variable(s) can be customized to manage this uninstall process:_

`perform_uninstall: <true | false>` (**default**: `false`)
- whether to uninstall and remove all artifacts and remnants of this `kafka` installation on a target host (**see**: `handlers/main.yml` for details)


Dependencies
------------

- 0x0i.systemd

Example Playbook
----------------
default example:
```
- hosts: all
  roles:
  - role: 0x0I.kafka
```

install specific version of Kafka binaries with pre-defined defaults:
```
- hosts: legacy-kafka-broker
  roles:
  - role: 0x0I.kafka
    vars:
        managed_configs: []
        install_type: archive
        archive_url: https://archive.apache.org/dist/kafka/1.0.0/kafka_2.12-1.0.0.tgz
```

adjust broker identification details:
```
- hosts: my-broker
  roles:
    - role: 0x0I.kafka
      vars:
        managed_configs: ['server_properties']
        server_properties:
          broker.id: 12
          advertised.host.name: my-broker.cluster.domain
```

launch Kafka brokers connecting to existing remote Zookeeper cluster and customize connection parameters:
```
- hosts: broker
  roles:
    - role: 0x0I.kafka
      vars:
        managed_configs: ['server_properties']
        server_properties:
          zookeeper.connect: 111.22.33.4:2181
          zookeeper.connection.timeout.ms: 30000
          zookeeper.max.in.flight.requests: 30
```

update Kafka commit log directory and parameters:
```
- hosts: broker
  roles:
    - role: 0x0I.kafka
      vars:
        managed_configs: ['server_properties']
        log_dirs: /mnt/data/kafka # can be provided in place of server property below
        server_properties:
          log.dirs: /mnt/data/kafka
          log.flush.interval.ms: 3000
          log.retention.hours: 168
          zookeeper.connect: zk1.cluster.domain:2181
```

adjust JVM settings for JMX metric collection and broker auditing:
```
- hosts: broker
  roles:
    - role: 0x0I.kafka
      vars:
        managed_configs: ['jvm_options']
        jvm_options:
          kafka_jmx_opts:
            - -Dcom.sun.management.jmxremote=true
            - -Dcom.sun.management.jmxremote.port=9999
            - -Dcom.sun.management.jmxremote.authenticate=false
            - -Dcom.sun.management.jmxremote.ssl=false
            - -Djava.net.preferIPv4Stack=true
```

increase log4j logging levels for troubleshooting/debugging:
```
- hosts: broker
  roles:
    - role: 0x0I.kafka
      vars:
        managed_configs: ['log4j_properties']
        log4j_properties:
          - comment: Set root logger level and log appenders
            settings:
              - log4j.rootLogger: DEBUG,stdout,kafkaAppender
          - comment: Define stdout logger appender
            settings:
              - log4j.appender.stdout: org.apache.log4j.ConsoleAppender
              - log4j.appender.stdout.layout: org.apache.log4j.PatternLayout
          - comment: Define kafka logger appender
            settings:
              - log4j.appender.kafkaAppender: org.apache.log4j.DailyRollingFileAppender
              - log4j.appender.kafkaAppender.DatePattern: "'.'yyyy-MM-dd-HH"
              - log4j.appender.kafkaAppender.File: "${kafka.logs.dir}/server.log"
              - log4j.appender.kafkaAppender.layout: org.apache.log4j.PatternLayout
```

License
-------

MIT

Author Information
------------------

This role was created in 2020 by O1.IO.
