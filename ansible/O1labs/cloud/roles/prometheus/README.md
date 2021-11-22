<p><img src="https://code.benco.io/icon-collection/logos/ansible.svg" alt="ansible logo" title="ansible" align="left" height="60" /></p>
<p><img src="https://cdn.worldvectorlogo.com/logos/prometheus.svg" alt="prometheus logo" title="prometheus" align="right" height="60" /></p>

Ansible Role :fire: :straight_ruler: Prometheus
=========
[![Galaxy Role](https://img.shields.io/ansible/role/45498.svg)](https://galaxy.ansible.com/0x0I/prometheus)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/0x0I/ansible-role-prometheus?color=yellow)
[![Downloads](https://img.shields.io/ansible/role/d/45498.svg?color=lightgrey)](https://galaxy.ansible.com/0x0I/prometheus)
[![Build Status](https://travis-ci.org/0x0I/ansible-role-prometheus.svg?branch=master)](https://travis-ci.org/0x0I/ansible-role-prometheus)
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

Ansible role that installs and configures Prometheus: a multi-dimensional, non-distributed time-series database and monitoring/alerting toolkit.

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

`prometheus` and its associated `alertmanager` can be installed using compressed archives (`.tar`, `.zip`), downloaded and extracted from various sources.

_The following variables can be customized to control various aspects of this installation process, ranging from software version and source location of binaries to the installation directory where they are stored:_

`managed_services: <list-of-services (prometheus | alertmanager)>` (**default**: *['prometheus']*)
- list of Prometheus toolkit services to manage via this role

`prometheus_user: <service-user-name>` (**default**: *prometheus*)
- dedicated service user and group used by `prometheus` for privilege separation (see [here](https://www.beyondtrust.com/blog/entry/how-separation-privilege-improves-security) for details)

`install_dir: </path/to/installation/dir>` (**default**: `/opt/prometheus`)
- path on target host where the `prometheus` binaries should be extracted to

`archive_url: <path-or-url-to-archive>` (**default**: see `defaults/main.yml`)
- address of a compressed **tar or zip** archive containing `prometheus` binaries. This method technically supports installation of any available version of `prometheus`. Links to official versions can be found [here](https://prometheus.io/download/#prometheus).

`archive_checksum: <path-or-url-to-checksum>` (**default**: see `defaults/main.yml`)
- address of a checksum file for verifying the data integrity of the specified `prometheus` archive. While recommended and generally considered a best practice, specifying a checksum is *not required* and can be disabled by providing an empty string (`''`) for its value.

`checksum_format: <string>` (**default**: see `sha256`)
- hash algorithm used for file verification associated with the specified archive checksum. Reference [here](https://en.wikipedia.org/wiki/Cryptographic_hash_function) for more information about *checksums/cryptographic* hashes.

`alertmgr_installdir: </path/to/installation/dir>` (**default**: `/opt/alertmanager`)
- path on target host where the `alertmanager` binaries should be extracted to

`exporter_installdir: </path/to/installation/dir>` (**default**: `{{ install_dir }}/exporters`)
- path on target host where Prometheus exporter binaries should be extracted to

`alertmgr_archive_url: <path-or-url-to-archive>` (**default**: see `defaults/main.yml`)
- address of a compressed **tar or zip** archive containing `alertmanager` binaries. This method technically supports installation of any available version of `alertmanager`. Links to official versions can be found [here](https://prometheus.io/download/#alertmanager).

`alertmgr_archive_checksum: <path-or-url-to-checksum>` (**default**: see `defaults/main.yml`)
- address of a checksum file for verifying the data integrity of the specified `alertmanager` archive. While recommended and generally considered a best practice, specifying a checksum is *not required* and can be disabled by providing an empty string (`''`) for its value.

`alertmgr_checksum_format: <string>` (**default**: see `sha256`)
- hash algorithm used for file verification associated with the specified archive checksum. Reference [here](https://en.wikipedia.org/wiki/Cryptographic_hash_function) for more information about *checksums/cryptographic* hashes.

`filesd_path: </path/to/file-sd-files>` (**default**: `{{ install_dir }}/filesd`)
- path on target host prometheus file discovery files should be stored by default

`rules_path: </path/to/rule-files>` (**default**: `{{ install_dir }}/rules.d`)
- path on target host prometheus rule files should be stored by default

`templates_path: </path/to/alertmanager-template-files>` (**default**: `{{ alertmgr_installdir }}/templates`)
- path on target host alertmanager template files  should be stored by default

#### Config

Using this role, configuration of a `prometheus` installation is organized according to the following components:

* prometheus service configuration (`prometheus.yml`)
* file service discovery (`file_sd - *.[json|yml]`)
* recording and alerting rules (`rule_files - *.[json|yml]`)
* alertmanager service configuration (`alertmanager.yml`)
* alertmanager template files (`*.tmpl`)

Each configuration can be expressed within the following variables in order to customize the contents and settings of the designated configuration files to be rendered:

`config_dir: </path/to/configuration/dir>` (**default**: `{{ install_dir }}`)
- path on target host where `prometheus` config files should be rendered

`data_dir: </path/to/data/dir>` (**default**: `/var/data/prometheus`)
- path on target host where `prometheus` stores data

`alertmgr_configdir: </path/to/configuration/dir>` (**default**: `{{ alertmgr_installdir }}`)
- path on target host where `alertmanager` config files should be rendered

`alertmgr_datadir: </path/to/data/dir>` (**default**: `/var/data/alertmanager`)
- path on target host where `alertmanager` stores data

#### Prometheus Service configuration

Prometheus service configuration can be expressed within the hash, `prometheus_config`, which contains a set of key-value pairs representing one of a set of sections indicating various scrape targets (sources from which to collect metrics), service discovery mechanisms, recording/alert rulesets and configurations for interfacing with remote read/write systems utlized by the Prometheus service.

The values of these keys are generally dicts or lists of dicts themselves containing a set of key-value pairs representing associated specifications/settings (e.g. the scrape interval or frequency at which to scrape targets for metrics globally) for each section. The following provides an overview and example configurations of each for reference.

###### :global

`[prometheus_config:] global: <key: value,...>` (**default**: see `defaults/main.yml`)
- specifies parameters that are valid and serve as defaults in all other configuration contexts. See  [here](https://prometheus.io/docs/prometheus/latest/configuration/configuration/) for more details.

##### Example

 ```yaml
  prometheus_config:
    global:
      # How frequently to scrape targets by default.
      scrape_interval: 15s
      # How long until a scrape request times out.
      scrape_timeout: 30s
      # How frequently to evaluate rules.
      evaluation_interval: 30s
      # The labels to add to any time series or alerts when communicating with
      # external systems (federation, remote storage, Alertmanager).
      external_labels:
        monitor: example
        foo: bar
  ```

###### :scrape_configs

`[prometheus_config:] scrape_configs: <list-of-dicts>` (**default**: see `defaults/main.yml`)
- specifies a set of targets and parameters describing how to scrape them organized into jobs

Targets may be statically configured or dynamically discovered using one of the supported service discovery mechanisms. See [here](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#scrape_config) for more details and [here](https://prometheus.io/docs/prometheus/latest/configuration/configuration/) for a list of supported service discovery methods.

##### Example

 ```yaml
  prometheus_config:
    scrape_configs:
      - job_name: static-example
        static_configs:
        - targets: ['localhost:9090', 'localhost:9191']
          labels:
            example: label
      - job_name: kubernetes-example
        kubernetes_sd_configs:
        - role: endpoints
          api_server: 'https://localhost:1234'
          namespaces:
            names:
              - default
  ```

###### :rule_files

`[prometheus_config:] rule_files: <list>` (**default**: see `defaults/main.yml`)
- specifies a list of globs indicating file names and paths

Rules and alerts are read from all matching files. Rules fall into one of two categories: recording and alerting. See [here](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/) for details surrounding recording rules and [here](https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/) for details surrounding alerting rules.

##### Example

 ```yaml
  prometheus_config:
    rule_files:
    - "example.yml"
    - "example_rules/*"
  ```

###### :remote_read

`[prometheus_config:] remote_read: <list-of-dicts>` (**default**: see `defaults/main.yml`)
- specifies settings related to the remote read feature

See [here](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_read) for more details.  For a list of available remote read/storage plugins/integrations, reference this [link](https://prometheus.io/docs/operating/integrations/#remote-endpoints-and-storage).

##### Example

 ```yaml
  prometheus_config:
    remote_read:
    - url: http://remote1/read
      read_recent: true
      name: default
    - url: http://remote2/read
      read_recent: false
      name: read_special
      required_matchers:
        job: special
      tls_config:
        cert_file: valid_cert_file
        key_file: valid_key_file
  ```

###### :remote_write

`[prometheus_config:] remote_write: <list-of-dicts>` (**default**: see `defaults/main.yml`)
- specifies settings related to the remote write feature

See [here](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_write) for more details. For a list of available remote write/storage plugins/integrations, reference this [link](https://prometheus.io/docs/operating/integrations/#remote-endpoints-and-storage).

##### Example

 ```yaml
  prometheus_config:
    remote_write:
    - name: drop_expensive
      url: http://remote1/push
      write_relabel_configs:
      - source_labels: [__name__]
        regex: expensive.*
        action: drop
    - name: rw_tls
      url: http://remote2/push
      tls_config:
        cert_file: valid_cert_file
        key_file: valid_key_file
  ```

###### :alerting

`[prometheus_config:] alerting: <key: value,...>` (**default**: see `defaults/main.yml`)
- specifies settings related to the Alertmanager in addition to Alertmanager instances the Prometheus server sends alerts to

This section provides the parameters to configure how to communicate with these Alertmanagers. Alertmanagers may be statically configured via the static configs parameter or dynamically discovered using one of the supported service discovery mechanims. See [here](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#alertmanager_config) for more details.

##### Example

 ```yaml
  prometheus_config:
    alerting:
      alertmanagers:
      - scheme: https
        static_configs:
      - targets:
        - "1.2.3.4:9093"
        - "1.2.3.5:9093"
  ```
#### File service discovery

File-based service discovery provides a more generic way to configure static targets and serves as an interface to plug in custom service discovery mechanisms. It reads a set of files containing a list of zero or more `<static_config>`s. Changes to all defined files are detected via disk watches and applied immediately. Files may be provided in YAML or JSON format. Only changes resulting in well-formed target groups are applied. See [here](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#file_sd_config) for more details.

`prometheus_file_sd: <list-of-dicts>` (**default**: [])
- specifies prometheus file_sd configurations to render

Using this role, file-based service discovery configuration settings can be expressed within the hash, `prometheus_file_sd`, which contains a list of dicts encapsulating the path, name and configuration contents of a `yaml` or `json` file set to be loaded by prometheus for file-based discovery.

`[prometheus_file_sd : <entry>:] name: <string>` (**default**: NONE - *required*)
- name of file_sd file to render

`[prometheus_file_sd : <entry>:] path: <string>` (**default**: `{{ install_dir }}/file_sd`)
- path of file_sd file to render

`[prometheus_file_sd : <entry>:] config: <list-of-dicts>` (**default**: NONE - *required*)
- list of dictionaries representing settings indicating set of static targets to specify in file_sd file

##### Example

 ```yaml
  prometheus_file_sd:
  - name: example-file.slow.json
    config:
    - targets: ["host1:1234"]
      labels:
        test-label: example-slow-file-sd
  - name: file.yml
    path: /etc/prometheus/file_sd
    config:
    - targets: ["host2:1234"]
  ```

  **NB:** An associated `file_sd` service discovery scrape_config is expected to be included within the `prometheus.yml` file for successful load.

#### Rule files

Prometheus supports two types of rules which may be configured and then evaluated at regular intervals: recording rules and alerting rules. Recording rules allow you to precompute frequently needed or computationally expensive expressions and save their result as a new set of time series.. Alerting rules allow you to define alert conditions based on Prometheus expression language expressions and to send notifications about firing alerts to an external service. See [here](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/) for more details.

`prometheus_rule_files: <list-of-dicts>` (**default**: [])
- specifies prometheus rule files to render

Using this role, both recording and alerting rules can be expressed within the hash, `prometheus_rule_files`, which contains a list of dicts encapsulating the path, name and configuration contents of a `yaml` or `json` file set to be loaded by prometheus for rule setting.

`[prometheus_rule_files : <entry>:] name: <string>` (**default**: NONE - *required*)
- name of rule file to render

`[prometheus_rule_files : <entry>:] path: <string>` (**default**: `{{ install_dir }}/rules.d`)
- path of rule file to render

`[prometheus_rule_files : <entry>:] config: <list-of-dicts>` (**default**: NONE - *required*)
- list of dictionaries representing settings indicating set of rule groups to specify in rule file

##### Example

 ```yaml
prometheus_rule_files:
- name: example-rules.yml
  config:
    groups:
    - name: recording rule example
      rules:
      - record: job:http_inprogress_requests:sum
        expr: sum(http_inprogress_requests) by (job)
- name: nondefault-path-example-rules.yml
  path: /etc/prometheus/rules.d
  config:
    groups:
    - name: alerting rule example
      rules:
      - alert: HighRequestLatency
        expr: job:request_latency_seconds:mean5m{job="myjob"} > 0.5
        for: 10m
        labels:
          severity: page
        annotations:
          summary: High request latency
  ```

**NB:** An associated `rule_files` section is expected to be included within the `prometheus.yml` file for successful load.

#### Alertmanager Service configuration

Alertmanager service configuration can be expressed within the hash, `alertmanager_config`, which contains a set of key-value pairs representing one of a set of sections indicating various route, receiver, templating and alert inhibition configurations.

The values of these keys are generally dicts or lists of dicts themselves containing a set of key-value pairs representing associated specifications/settings (e.g. the API URL to use for Slack notifications) for each section. The following provides an overview and example configurations of each for reference.

###### :global

`[alertmanager_config:] global: <key: value,...>` (**default**: see `defaults/main.yml`)
- specifies parameters that are valid and serve as defaults in all other configuration contexts. See [here](https://prometheus.io/docs/alerting/configuration/) for more details.

##### Example

 ```yaml
  alertmanager_config:
    global:
      # The smarthost and SMTP sender used for mail notifications.
      smtp_smarthost: 'localhost:25'
      smtp_from: 'alertmanager@example.org'
      smtp_auth_username: 'alertmanager'
      smtp_auth_password: 'password'
      # The auth token for Hipchat.
      hipchat_auth_token: '1234556789'
      # Alternative host for Hipchat.
      hipchat_api_url: 'https://hipchat.foobar.org/'
  ```

###### :route

`[alertmanager_config:] route: <key: value,...>` (**default**: see `defaults/main.yml`)
- defines a node in a routing tree and its children

Every alert enters the routing tree at the configured top-level route, which must match all alerts (i.e. not have any configured matchers). It then traverses the child nodes. If continue is set to false, it stops after the first matching child. If continue is true on a matching node, the alert will continue matching against subsequent siblings. See [here](https://prometheus.io/docs/alerting/configuration/#route) for more details.

##### Example

 ```yaml
  alertmanager_config:
    route:
      receiver: 'default-receiver'
      group_wait: 30s
      group_interval: 5m
      repeat_interval: 4h
      group_by: [cluster, alertname]
      # All alerts that do not match the following child routes
      # will remain at the root node and be dispatched to 'default-receiver'.
      routes:
        # All alerts with service=mysql or service=cassandra
        # are dispatched to the database pager.
      - receiver: 'database-pager'
        group_wait: 10s
        match_re:
          service: mysql|cassandra
      # All alerts with the team=frontend label match this sub-route.
      # They are grouped by product and environment rather than cluster
      # and alertname.
      - receiver: 'frontend-pager'
        group_by: [product, environment]
        match:
          team: frontend
  ```

###### :receivers

`[alertmanager_config:] inhibit_rules: <list-of-dicts>` (**default**: see `defaults/main.yml`)
- specifies a list of notification receivers

Receivers are named configuration of one or more notification integrations. See [here](https://prometheus.io/docs/alerting/configuration/#receiver) for more details.

##### Example

 ```yaml
  alertmanager_config:
    receivers:
    - name: 'team-X-mails'
      email_configs:
      - to: 'team-X+alerts@example.org'
      pagerduty_configs:
      - service_key: <team-X-key>
      hipchat_configs:
      - auth_token: <auth_token>
        room_id: 85
        message_format: html
        notify: true
  ```

###### :inhibit_rules

`[alertmanager_config:] inhibit_rules: <list-of-dicts>` (**default**: see `defaults/main.yml`)
- specifies a list of inhibition rules

An inhibition rule mutes an alert (target) matching a set of matchers when an alert (source) exists that matches another set of matchers. See [here](https://prometheus.io/docs/alerting/configuration/#inhibit_rule) for more details.

##### Example

 ```yaml
  alertmanager_config:
    inhibit_rules:
    - source_match:
        severity: 'critical'
      target_match:
        severity: 'warning'
      # Apply inhibition if the alertname is the same.
      equal: ['alertname', 'cluster', 'service']
  ```

###### :templates

`[alertmanager_config:] templates: <list>` (**default**: see `defaults/main.yml`)
- specifies files and directories from which notification templates are read

The last component may use a wildcard matcher, e.g. `templates/*.tmpl`. See [here](https://prometheus.io/docs/alerting/notifications/) for a notification template reference and this [link](https://prometheus.io/docs/alerting/notification_examples/) for examples.

##### Example

 ```yaml
  alertmanager_config:
    templates:
    - '/etc/alertmanager/template/*.tmpl'
  ```

#### Alertmanager templates

Prometheus creates and sends alerts to the Alertmanager which then sends notifications out to different receivers based on their labels. The notifications sent to receivers are constructed via templates. The Alertmanager comes with default templates but they can also be customized. See [here](https://prometheus.io/docs/alerting/notifications/) for more details.

`altermanager_templates: <list-of-dicts>` (**default**: [])
- specifies `alertmanager` notification template configurations to render

Using this role, alertmanager template configuration settings can be expressed within the hash, `alertmanager_templates`, which contains a list of dicts representing and encapsulating the path, name and configuration contents of a `tmpl` file set to be loaded by alertmanager.

`[alertmanager_templates : <entry>:] name: <string>` (**default**: NONE - *required*)
- name of template file to render

`[alertmanager_templates : <entry>:] path: <string>` (**default**: `{{ alertmgr_installdir }}/templates`)
- path of template file to render

`[alertmanager_templates : <entry>:] config: <list-of-dicts>` (**default**: NONE - *required*)
- list of dictionaries representing settings indicating set of template configs to render

##### Example

 ```yaml
  alertmanager_templates:
  - name: test
    config:
    - define: "myorg.test.guide"
      template: 'https://internal.myorg.net/wiki/alerts/\{\{ .GroupLabels.app \}\}/\{\{ .GroupLabels.alertname \}\}'
  - name: test2
    path: /etc/alertmanager/templates
    config:
    - define: "myorg.test.text"
      template: 'summary: \{\{ .CommonAnnotations.summary \}\}\ndescription: \{\{ .CommonAnnotations.description \}\}'
  ```

  **NB:** An associated `templates` config section is expected to be included within the `alertmanager.yml` file for successful load.

#### Launch

This role supports launching all components of the Prometheus monitoring and alerting toolkit ecosystem. This consists of both the Prometheus and Alertmanager services and a myriad of metric exporters. Running each is accomplished utilizing the [systemd](https://www.freedesktop.org/wiki/Software/systemd/) service management tool which manages the services as background processes or daemons subject to the configuration and execution potential provided by its underlying management framework.

_The following variables can be customized to manage the services' **systemd** [Service] unit definition and execution profile/policy:_

###### Prometheus

`extra_run_args: <prometheus-cli-options>` (**default**: `[]`)
- list of `prometheus` commandline arguments to pass to the binary at runtime for customizing launch.

Supporting full expression of `prometheus`'s [cli](https://gist.github.com/0x0I/eec137d55a26a16d836b84cbc186ab52), this variable enables the launch to be customized according to the user's specification.

`custom_unit_properties: <hash-of-systemd-service-settings>` (**default**: `[]`)
- hash of settings used to customize the `[Service]` unit configuration and execution environment of the *Prometheus* **systemd** service.

###### Alertmanager

`extra_alertmgr_args: <alertmanager-cli-options>` (**default**: `[]`)
- list of `alertmanager` commandline arguments to pass to the binary at runtime for customizing launch.

Supporting full expression of `alertmanager`'s [cli](https://gist.github.com/0x0I/4eb3d7841562d215b50f05dee64fa0dc), this variable enables the launch to be customized according to the user's specification.

`custom_alertmgr_properties: <hash-of-systemd-service-settings>` (**default**: `[]`)
- hash of settings used to customize the `[Service]` unit configuration and execution environment of the *Alertmanager* **systemd** service.

###### Exporters

`prometheus_exporters: <list-of-dicts>` (**default**: [])
- specifies prometheus exporters to install and launch and manage as a systemd services.

Each exporter dict entry is expected to indicate several properties, including name; url and listen address, of the target exporter for proper setup and communication with a *Prometheus* server. Other properties used to customize operation of the exporter can optionally be specified via an `extra_args` variable, which appends provided command-line arguments to the exporter's unit *ExecStart* setting. See [here](https://prometheus.io/docs/instrumenting/exporters/) for more details and a list of exporter plugins for reference.

`[prometheus_exporters : <entry>:] name: <string>` (**default**: NONE - *required*)
- name of Prometheus exporter to install

`[prometheus_exporters : <entry>:] url: <string>` (**default**: NONE - *required*)
- URL of Prometheus exporter to install

`[prometheus_exporters : <entry>:] description: <string>` (**default**: `<exporter-name>`)
- description or documentation of Prometheus exporter to include within exporter's *Systemd* unit file

`[prometheus_exporters : <entry>:] unit_properties: <hash>` (**default**: `{}`)
- hash of settings used to customize the `[Service]` unit configuration and execution environment of the *<exporter>* **systemd** service

##### Example

 ```yaml
  prometheus_exporters:
    - name: node_exporter
      url: https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz
      description: https://github.com/prometheus/node_exporter
      unit_properties:
        User: exporter
        Group: exporter
      extra_args:
        - '--web.listen-address=0.0.0.0:9110'
        - '--log.level=debug'
  ```

#### Uninstall

Support for uninstalling and removing artifacts necessary for provisioning allows for users/operators to return a target host to its configured state prior to application of this role. This can be useful for recycling nodes and roles and perhaps providing more graceful/managed transitions between tooling upgrades.

_The following variable(s) can be customized to manage this uninstall process:_

`perform_uninstall: <true | false>` (**default**: `false`)
- whether to uninstall and remove all artifacts and remnants of this `prometheus` installation on a target host (**see**: `handlers/main.yml` for details)

Dependencies
------------

- 0x0i.systemd

Example Playbook
----------------
default example:
```
- hosts: all
  roles:
  - role: 0x0I.prometheus
```

*only* install and manage the Prometheus service (disable alertmanager setup):
```
- hosts: all
  roles:
  - role: 0x0I.prometheus
    vars:
      managed_services: ['prometheus']
```

install specific version of Prometheus bits:
```
- hosts: all
  roles:
  - role: 0x0I.prometheus
    vars:
      archive_url: https://github.com/prometheus/prometheus/releases/download/v2.15.0/prometheus-2.15.0.linux-amd64.tar.gz
      archive_checksum: 1c2175428e7a70297d97a30a04278b86ccd6fc53bf481344936d6573482203b4
```

adust Prometheus and Alertmanager installation, configuration and data directories:
```
- hosts: all
  roles:
  - role: 0x0I.prometheus
    vars:
      install_dir: /usr/local
      config_dir: /etc/prometheus
      data_dir: /var/lib/prometheus
      alertmgr_installdir: /usr/local
      alertmgr_configdir: /etc/alertmanager
      alertmgr_datadir: /var/lib/alertmanager
```

customize global scrape and evaluation settings:
```
- hosts: all
  roles:
  - role: 0x0I.prometheus
    vars:
      prometheus_config:
        global:
          scrape_interval: 30s
          scrape_timeout: 30s
          evaluation_interval: 30s
```

customize prometheus alerting/alertmanager configuration:
```
- hosts: all
  roles:
  - role: 0x0I.prometheus
    vars:
      prometheus_config:
        alerting:
          alertmanagers:
          - scheme: https
            static_configs:
            - targets:
              - "1.2.3.4:9093"
```

create recording and alerting rules:
```
- hosts: all
  roles:
  - role: 0x0I.prometheus
    vars:
      prometheus_config:
        rule_files:
        - /etc/prometheus/rules.d/*
      prometheus_rule_files:
      - name: example-rules.yml
        path: /etc/prometheus/rules.d/*
        config:
          groups:
            - name: recording rule example
              rules:
                - record: job:http_inprogress_requests:sum
                  expr: sum(http_inprogress_requests) by (job)
      - name: another-example.yml
        path: /etc/prometheus/rules.d
        config:
          groups:
            - name: alerting rule example
              rules:
                - alert: HighRequestLatency
                  expr: job:request_latency_seconds:mean5m{job="myjob"} > 0.5
                  for: 10m
                  labels:
                    severity: page
                  annotations:
                    summary: High request latency
```

`static` target scrape_config with scrape and evaluation setting overrides:
```
- hosts: all
  roles:
  - role: 0x0I.prometheus
    vars:
      prometheus_config:
        scrape_configs:
        - job_name: static-example
           static_configs:
           - targets: ['localhost:9090', 'localhost:9191']
             labels:
               my:   label
               your: label
          scrape_interval: 10s
          scrape_timeout: 10s
          evaluation_interval: 10s
```

`file_sd` file-based scrape_config with scrape and evaluation setting overrides:
```
- hosts: all
  roles:
  - role: 0x0I.prometheus
    vars:
      prometheus_config:
        scrape_configs:
        - job_name: file-sd-example
            file_sd_configs:
            - files:
              - foo/*.slow.json
              - single/file.yml
              refresh_interval: 10m
            - files:
             - bar/*.yml
      prometheus_file_sd:
      - name: example-file.slow.json
        path: foo
        config:
        - targets: ["host1:1234"]
          labels:
            test-label: example-slow-file-sd
      - name: foo.yml
        path: bar
        config:
        - targets: ["host2:1234"]
      - name: file.yml
        path: single
        config:
        - targets: ["host3:1234"]
```

`dns`-based target scrape_config:
```
- hosts: all
  roles:
  - role: 0x0I.prometheus
    vars:
      prometheus_config:
        scrape_configs:
        - job_name: dns-example
          dns_sd_configs:
          - refresh_interval: 15s
            names:
            - first.dns.address.domain.com
            - second.dns.address.domain.com
          - names:
            - third.dns.address.domain.com
```

`kubernetes` target scrape_config with TLS and basic authentication settings configured:
```
- hosts: all
  roles:
  - role: 0x0I.prometheus
    vars:
      prometheus_config:
        scrape_configs:
        - job_name: kubernetes-example
          kubernetes_sd_configs:
          - role: endpoints
            api_server: 'https://localhost:1234'
            tls_config:
              cert_file: valid_cert_file
              key_file: valid_key_file
            basic_auth:
              username: 'myusername'
              password: 'mysecret'
```

`ec2` target scrape_config:
```
- hosts: all
  roles:
  - role: 0x0I.prometheus
    vars:
      prometheus_config:
        scrape_configs:
        - job_name: ec2-example
          ec2_sd_configs:
          - region: us-east-1
            access_key: access
            secret_key: mysecret
            profile: profile
            filters:
            - name: tag:environment
              values:
              - prod
            - name: tag:service
              values:
              - web
              - db
```

`openstack` target scrape_config:
```
- hosts: all
  roles:
  - role: 0x0I.prometheus
    vars:
      prometheus_config:
        scrape_configs:
        - job_name: openstack-example
          openstack_sd_configs:
          - role: instance
            region: RegionOne
            port: 80
            refresh_interval: 1m
```

`azure` target scrape_config:
```
- hosts: all
  roles:
  - role: 0x0I.prometheus
    vars:
      prometheus_config:
        scrape_configs:
        - job_name: azure-example
          azure_sd_configs:
    -       environment: AzurePublicCloud
            authentication_method: OAuth
            subscription_id: 11AAAA11-A11A-111A-A111-1111A1111A11
            tenant_id: BBBB222B-B2B2-2B22-B222-2BB2222BB2B2
            client_id: 333333CC-3C33-3333-CCC3-33C3CCCCC33C
            client_secret: mysecret
            port: 9100
```

`marathon` target scrape_config:
```
- hosts: all
  roles:
  - role: 0x0I.prometheus
    vars:
      prometheus_config:
        scrape_configs:
        - job_name: marathon-example
          marathon_sd_configs:
          - servers:
            - 'https://marathon.example.com:443'
            auth_token: "mysecret"
```

`consul` target scrape_config:
```
- hosts: all
  roles:
  - role: 0x0I.prometheus
    vars:
      prometheus_config:
        scrape_configs:
        - job_name: consul-example
          consul_sd_configs:
          - server: 'localhost:1234'
            token: mysecret
            services: ['nginx', 'cache', 'mysql']
            tags: ["canary", "v1"]
            node_meta:
              rack: "123"
            allow_stale: true
            scheme: https
```

License
-------

MIT

Author Information
------------------

This role was created in 2019 by O1.IO.
