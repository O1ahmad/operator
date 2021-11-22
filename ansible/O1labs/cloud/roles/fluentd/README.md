<p><img src="https://code.benco.io/icon-collection/logos/ansible.svg" alt="ansible logo" title="ansible" align="left" height="60" /></p>
<p><img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTO8QjLQz_23H_dpfCmt6qDze_oIN-fZMbuaLfZbIZTp4bFrJ4M&s" alt="fluentd logo" title="fluentd" align="right" height="60" /></p>

Ansible Role :cyclone: :ticket: Fluentd
=========
[![Galaxy Role](https://img.shields.io/ansible/role/45215.svg)](https://galaxy.ansible.com/0x0I/fluentd)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/0x0I/ansible-role-fluentd?color=yellow)
[![Downloads](https://img.shields.io/ansible/role/d/45215.svg?color=lightgrey)](https://galaxy.ansible.com/0x0I/fluentd)
[![Build Status](https://travis-ci.org/0x0I/ansible-role-fluentd.svg?branch=master)](https://travis-ci.org/0x0I/ansible-role-fluentd)
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

Ansible role that installs and configures Fluentd: a unified and scalable logging and data collection service.

##### Supported Platforms:
```
* Debian
* Redhat(CentOS/Fedora)
* Ubuntu
```

Requirements
------------

A Ruby environment for gem installation types. 

Role Variables
--------------
Variables are available and organized according to the following software & machine provisioning stages:
* _install_
* _config_
* _launch_
* _uninstall_

#### Install

`fluentd_user: <service-user-name>` (**default**: *fluentd*)
- dedicated service user and group used by `fluentd` for privilege separation (see [here](https://www.beyondtrust.com/blog/entry/how-separation-privilege-improves-security) for details)

`install_type: <package | gem>` (**default**: gem)
- **package**: maintained by the Treasure Data organization for Debian and Redhat distributions, package installation of `fluentd` pulls the specified package from the respective package `td-agent` management repository. See `fluentd`'s official [installation guide](https://docs.fluentd.org/installation) for more details.
  - Note that the installation directory is determined by the package management system and currently defaults to `/opt/td-agent` for both distros.
- **gem**: installs fluentd gem from the offical Ruby gems community hosting site, [rubygems.org](https://rubygems.org).

`gem_version: <string>` (**default**: `1.7.4`)
- version of `fluentd` gem to install. Reference [here](https://rubygems.org/gems/fluentd) for a list of available versions.

`package_url: <path-or-url-to-package>` (**default**: see `defaults/main.yml`)
- address of a **Debian or RPM** package containing `td-agent` source and binaries.

Note that the installation layout is determined by the package management systems. Consult Fluentd's official documentation for both [RPM](https://docs.fluentd.org/installation/install-by-rpm) and [Debian](https://docs.fluentd.org/installation/install-by-deb) installation details.

`plugins: <list-of-strings>` (**default**: `[]`)
- list of `fluentd` plugins to install. See `fluentd`'s [community](https://www.fluentd.org/plugins) site for the set of available plugins.

#### Config

Configuration of `fluentd` is expressed within a single configuration file, *fluentd.conf or td-agent.conf (depending on install type)*. By default, the file is located in a designated config directory determined by the installation type though it's location can be customized by setting the environment variable `FLUENT_CONF` within the services execution environment to the desired location.

The configuration file allows the user to control the input and output behavior of Fluentd by (1) selecting input and output plugins and (2) specifying the plugin parameters. It is required for Fluentd to operate properly.

See `fluentd`'s official [configuration guide](https://docs.fluentd.org/configuration) for more details.

_The following variable can be customized to manage the content of this configuration file and others to included by the **@include** directive:_

`config: <list-of-plugin-settings-hashes>` **default**: {}

- `{fluent|td-agent}.conf` consists of specifications of fluentd plugins, which manage various aspects or directives of the log and data ingestion process. These directives are as follows:
   - **source**: determine the input sources.
   - **match**: determine the output destinations.
   - **filter**: determine the event processing pipelines.
   - **system**: set system wide configuration.
   - **label**: group the output and filter for internal routing
   - **@include**: include other files

Utilizing this role, each directive to be rendered in the default configuration file or any included by the **@include** directive is fully expressible via two forms, either a hash of directive attributes or a single `content` key with a value representing an actual directive definition. See below for examples.

#### Example
```yaml
config:
  - directives:
    - comment: Directive specified by attributes -- Listen on localhost:2411 for source data injections
      plugin: source
      attributes:
        "@type": http
        "@id": example
        port: 2411
    - comment: Directive specified by content field -- Add hostname where data was emitted from
      plugin: filter
      content: |
        <filter example>
          @type record_transformer
          <record>
            hostname "#{Socket.gethostname}"
          </record>
        </filter>
    - plugin: match
      match: "test.*"
      attributes:
        "@type": stdout
```
`[config: {list-entry} :] name: <string>` (**default**: *fluentd | td-agent*)
- [optional] As previously mentioned, the **@include** directive allows configuration files to be loaded from locations across the host file-system. This parameter represents the name of the configuration file to render a set of directives (to follow) in as well as the name of the file that would be a part of such an **@include**.

`[config: {list-entry} :] path: <string>` (**default**: */etc/fluentd | /etc/td-agent*)
- [optional] represents the path to the configuration file on the local host

`[config: {list-entry} :] directives: <list-of-hashes>` (**default**: *none*)
- list of directive hashes to render in the configuration file specified by the above parameters

`[config: {list-entry} : directives: {list-entry}:] comment: <string>` (**default**: *none*)
- [optional] comment associated with plugin directive

`[config: {list-entry} : directives: {list-entry}:] plugin: <string>` (**default**: *none*)
- type of plugin directive

`[config: {list-entry} : directives: {list-entry}:] match: <string>` (**default**: *none*)
- regular expression to match with **match** directives

`[config: {list-entry} : directives: {list-entry}:] attributes: <hash>` (**default**: *none*)
- directive specific attributes to include in definition. See `fluentd`'s official [built-in](https://docs.fluentd.org/input) or [community](https://www.fluentd.org/plugins) sites for the set of available attributes for each plugin.

`[config: {list-entry} : directives: {list-entry}:] content: <string>` (**default**: *none*)
- actual representation of the directive definition. Value can contain formatting as expected to be set in a `fluentd/td-agent.conf` config file. See [here](https://github.com/fluent/fluentd/tree/master/example) for examples.

#### Launch

`extra_run_args: <fluentd-cli-options>` (**default**: `[]`)
- list of `fluentd` commandline arguments to pass to the binary at runtime for customizing launch. Supporting full expression of `fluentd`'s cli, this variable enables the launch to be customized according to the user's specification.

`custom_unit_properties: <hash-of-systemd-service-settings>` (**default**: `[]`)
- hash of settings used to customize the [Service] unit configuration and execution environment of the Fluentd **systemd** service.

```yaml
custom_unit_properties:
  Environment: "FLUENT_CONF=/path/to/custom/config.conf"
  LimitNOFILE: infinity
```

Reference the [systemd.service](http://man7.org/linux/man-pages/man5/systemd.service.5.html) *man* page for a configuration overview and reference.

#### Uninstall

`perform_uninstall: <true | false>` (**default**: `false`)
- whether to uninstall and remove all artifacts and remnants of this `fluentd` installation on a target host (**see**: `handlers/main.yml` for details)

Dependencies
------------

- 0x0i.systemd

Example Playbook
----------------
default example:
```
- hosts: all
  roles:
  - role: 0x0I.fluentd
```

install specific version of fluentd gem:
```
- hosts: all
  roles:
    - role: 0x0I.fluentd
      vars:
        install_type: gem
        gem_version: 1.8.0
```

include all custom configurations defined separately from default config:
```
- hosts: all
  roles:
    - role: 0x0I.fluentd
      vars:
        config:
          - directives:
              - comment: include all custom directive configurations
                plugin: include
                content: |
                  @include /etc/td-agent/conf.d/*.conf
          - name: "example-pipeline"
            path: /etc/td-agent/conf.d
            directives:
              - plugin: source
                attributes:
                  "@type": stdin
                  format: none
                  tag: example.input
              - plugin: match
                match: "example.*"
                attributes:
                  "@type": stdout
```

add directives for debugging/troubleshooting:
```
- hosts: all
  roles:
    - role: 0x0I.fluentd
      vars:
        install_type: package
        config:
          - directives:
              - comment: set pipeline global log-level
                plugin: system
                attributes:
                  log_level: debug
              - comment: activate debug-agent listening on specified port
                plugin: source
                attributes:
                  "@type": debug_agent
                  bind: 127.0.0.1
                  port: 24230
              - plugin: match
                match: "*"
                attributes:
                  "@type": stdout
```

License
-------

MIT

Author Information
------------------

This role was created in 2019 by O1.IO.
