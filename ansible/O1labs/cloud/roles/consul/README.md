<p><img src="https://code.benco.io/icon-collection/logos/ansible.svg" alt="ansible logo" title="ansible" align="left" height="60" /></p>
<p><img src="https://d7umqicpi7263.cloudfront.net/img/product/4c3eb104-ebd1-42be-9bd4-de25ef6918df/fd0db979-c8f1-4fbd-b900-fb2a15e19e6b.png" alt="consul logo" title="consul" align="right" height="80" /></p>

Ansible Role :satellite: :low_brightness: Consul
=========
[![Galaxy Role](https://img.shields.io/ansible/role/45968.svg)](https://galaxy.ansible.com/0x0I/consul)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/0x0I/ansible-role-consul?color=yellow)
[![Downloads](https://img.shields.io/ansible/role/d/45968.svg?color=lightgrey)](https://galaxy.ansible.com/0x0I/consul)
[![Build Status](https://travis-ci.org/0x0I/ansible-role-consul.svg?branch=master)](https://travis-ci.org/0x0I/ansible-role-consul)
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

Ansible role that installs and configures Consul: a service discovery, mesh and configuration control plane and networking tool.

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

`consul`can be installed using compressed archives (`.tar`, `.zip`), downloaded and extracted from various sources, or built from *git* source.

_The following variables can be customized to control various aspects of this installation process, ranging from software version and source location of binaries to the installation directory where they are stored:_

`consul_user: <service-user-name>` (**default**: *consul*)
- dedicated service user and group used by `consul` for privilege separation (see [here](https://www.beyondtrust.com/blog/entry/how-separation-privilege-improves-security) for details)

`install_type: <archive | source>` (**default**: archive)
- **archive**: currently compatible with both **tar and zip** formats, installation of Consul via compressed archives results in the direct download of its component binaries, consisting of the `consul` server and client agent, from the specified archive url.

  **note:** archived installation binaries can be obtained from the official [releases](https://www.consul.io/downloads.html) site or those generated from development/custom sources.

- **source**: build *consul server and client* binaries from source. This installation process consists of cloning the github hosted [repository](https://github.com/hashicorp/consul/releases) and building from source code using `make` directives. See [here](https://www.consul.io/docs/install/index.html#compiling-from-source) for more details on building from source.

`install_dir: </path/to/installation/dir>` (**default**: `/opt/consul`)
- path on target host where the `consul` binaries should be extracted to.

`archive_url: <path-or-url-to-archive>` (**default**: see `defaults/main.yml`)
- address of a compressed **tar or zip** archive containing `consul` binaries. This method technically supports installation of any available version of `consul`. Links to official versions can be found [here](https://releases.hashicorp.com/consul/).

`archive_checksum: <path-or-url-to-checksum>` (**default**: see `defaults/main.yml`)
- address of a checksum file or actual checksum for verifying the data integrity of the specified archive. While recommended and generally considered a best practice, specifying a checksum is *not required* and can be disabled by providing an empty string (`''`) for its value.

`checksum_format: <string>` (**default**: see `sha512`)
- hash algorithm used for file verification associated with the specified archive or package checksum. Reference [here](https://en.wikipedia.org/wiki/Cryptographic_hash_function) for more information about *checksums/cryptographic* hashes.

`archive_options: <untar-or-unzip-options>` (**default**: `[]`)
- list of additional unarchival arguments to pass to either the `tar` or `unzip` binary at runtime for customizing how the archive is extracted to the designated installation directory. See [man tar](https://linux.die.net/man/1/tar) and [man unzip](https://linux.die.net/man/1/unzip) for available options to specify, respectively.

`git_url: <path-or-url-to-git-repo>` (**default**: see `defaults/main.yml`)
- address of `consul` git repository. Address can reference the [Github](https://github.com/hashicorp/consul) site address or custom source hosted on an alternate git hosting site.

`git_version: <string>` (**default**: `v1.6.2`)
- version of the *Git* repository to check out. This can be the literal string HEAD, a branch name or a tag name.

`go_autoinstall: <true|false>` (**default**: `false`)
- automatically install the specified version of Go packages and binaries. Useful when installing from source which requires `go` as a part of its build process

`go_url: <path-or-url-to-archive>` (**default**: see `defaults/main.yml`)
- address of a compressed **tar or zip** archive containing `go` binaries or source for compilation. This method technically supports installation of any available version of `go`. Links to official versions can be found [here](https://golang.org/dl/). *ONLY* relevant when installing on **non-Ubuntu** linux distributions.

`go_install_dir: </path/to/install/dir>` (**default**: `/usr/local`)
- path on target host where the `go` binaries should be extracted to.

#### Config

Consul supports specification of multiple configuration files or definitions for controlling various aspects of an agent's behavior. These definitions are expected to be expressed in either `JSON` or `HCL` format and to adhere to the syntax framework and rules outlined in *Consul's* official docs and as determined by the community.

Each of these configurations can be expressed using the `consul_configs` hash, which contains a list of various Consul agent configuration options:
* agent settings
* config entries (e.g. *service-defaults, service-routers, service-splitters*)
* service registrations
* check or service healthcheck directives

These hashes contain a list of structures specific to each configuration type for declaring the desired agent settings to be rendered in addition to common amongst them all, `:name, :path and :config` which specify the name and path of the configuration file to render and a hash of the configuration to set.

See [here](https://www.consul.io/docs/agent/config_entries.html) for more details as well as a list of supported options for each configuration type and reference the following for a more in-depth explanation in addition to examples of each.

`[consul_configs: <entry>:] name: <string>` (**default**: *required*)
- name of the configuration file to render on the target host (excluding the file extension)

`[consul_configs: <entry>:] type: <json|hcl>` (**default**: *json*)
- type or format of the configuration file to render. Configuration can be either in JSON or [HCL](https://github.com/hashicorp/hcl#syntax) format (though ONLY `json` is currently supported).

`[consul_configs: <entry>:] path: </path/to/config>` (**default**: */etc/consul.d*)
- path of the configuration file to render on the target host

  **Note:** When loading configuration, Consul loads the configuration from files and directories in lexical order. Configuration specified later will be merged into configuration specified earlier. In general, "merge" results in the later version overriding the earlier. In some cases, such as event handlers, merging appends the handlers to the existing configuration.

`[consul_config: <entry>:] config: <JSON>` (**default**: )
- specifies parameters that manage various aspects of a consul agent's operations

[Reference here](https://www.consul.io/docs/agent/options.html) for a list of supported configuration options.

##### Example

 ```yaml
  consul_configs:
    - name: example-config
      path: /example/path
      config:
        data_dir: /var/lib/consul
        log_level: debug
  ```
  
##### Service Definitions

Agents provide a simple service definition format to declare the availability of a service and to potentially associate it with a health check. Each service definition must include a name and may optionally provide an *id, tags, address, meta, port, enable_tag_override, and check*. See [here](https://www.consul.io/docs/agent/services.html) for more details regarding these optional arguments and suggestions on their usage.

`[consul_config: <entry>: config: service:] <JSON>` (**default**: )
- specifies parameters that manage Consul service registration

##### Example

 ```yaml
  consul_configs:
    - name: example-service-definition
      # type: json
      # path: /etc/consul.d
      config:
        service:
          id: redis
          name: redis
          tags: ['prod']
          port: 8000
          enable_tag_override: false
          checks:
            - args: ["/usr/local/bin/check_redis.py"],
              interval: 10s
  ```
  
##### Config Entries

Configuration entries can be created to provide cluster-wide defaults for various aspects of Consul. Every configuration entry has at least two fields: **Kind** and **Name**. Those two fields are used to uniquely identify a configuration entry. When put into configuration files, configuration entries can be specified as *HCL or JSON objects* using either snake_case or CamelCase for key names.

###### Service Defaults

Service Defaults, one of the five config entry objects supported by Consul, control default global values for a service, such as its protocol, MeshGateway topology settings, list of paths to expose through Envoy and ACLs or access-control-lists. Specification of these options are expected to be defined within the `config : config_entries : bootstrap` hash list. See [here](https://www.consul.io/docs/agent/config-entries/service-defaults.html) for more details regarding available configuration settings and suggested usage.

`[consul_config: <entry>: config: config_entries : bootstrap:] <JSON list entry>` (**default**: [])
- specifies parameters that manage default settings for a particular service group 

##### Example

 ```yaml
  consul_configs:
    - name: example-service-defaults
      config:
        config_entries:
          bootstrap:
            - Kind: service-defaults
              Name: example-api
              Protocol: http
  ```
  
###### Proxy Defaults

Allowing for setting global proxy defaults across all services for Connect proxy configuration, *proxy defaults* express arbitrary values which depend on and determine the behavior of the specific Connect proxy being employed. Like *Service Defaults*, specification of these options are expected to be defined within the `config : config_entries : bootstrap` hash list.

See [here](https://www.consul.io/docs/agent/config-entries/proxy-defaults.html) for more details regarding available Connect proxies, configuration settings and suggested usage.

`[consul_config: <entry>: config: config_entries : bootstrap:] <JSON list entry>` (**default**: [])
- specifies parameters that manage default proxy settings for the global Consul namespace 

##### Example

 ```yaml
  consul_configs:
    - name: example-proxy-defaults
      config:
        config_entries:
          bootstrap:
            - Kind: proxy-defaults
              Name: global
              config:
                local_connect_timeout_ms: 1000
                handshake_timeout_ms: 1000
  ```
  
###### Service Router

The service-router config entry kind controls Consul/Connect traffic routing and manipulation at networking layer 7 (e.g. HTTP). If a router is not explicitly configured or is configured with no routes then the system behaves as if a router were configured sending all traffic to a service of the same name.

Service router config entries are restricted to only services that define their protocol as http-based via a corresponding service-defaults config entry or globally via proxy-defaults. Like *Service Defaults*, specification of these options are expected to be defined within the `config : config_entries : bootstrap` hash list.

See [here](https://www.consul.io/docs/agent/config-entries/service-router.html) for more details regarding available configuration settings and suggested usage.

`[consul_config: <entry>: config: config_entries : bootstrap:] <JSON list entry>` (**default**: [])
- specifies parameters that manage router settings for a particular group of services 

##### Example

 ```yaml
  consul_configs:
    - name: example-proxy-defaults
      config:
        config_entries:
          bootstrap:
            - Kind: service-router
              Name: example-api
              routes:
                - match:
                    http:
                      path_prefix: /admin
                  destination:
                    service: admin
                - match:
                    http:
                      header:
                        - name: x-debug
                          exact: 1
                  destination:
                    service: web
                    service_subset: canary
  ```

###### Service Splitter

The service-splitter config entry kind controls how to split incoming Connect requests across different subsets of a single service (like during staged canary rollouts), or perhaps across different services (like during a v2 rewrite or other type of codebase migration).

If no splitter config is defined for a service it is assumed 100% of traffic flows to a service with the same name and discovery continues on to the resolution stage.

See [here](https://www.consul.io/docs/agent/config-entries/service-splitter.html) for more details regarding available configuration settings and suggested usage.

`[consul_config: <entry>: config: config_entries : bootstrap:] <JSON list entry>` (**default**: [])
- specifies parameters that manage splitting of service traffic across various flows

##### Example

 ```yaml
  consul_configs:
    - name: example-service-splitter
      config:
        config_entries:
          bootstrap:
            - Kind: service-splitter
              Name: example-api
              splits:
                - weight: 90
                  service_subset: "v1"
                - weight: 10
                  service_subset: "v2"
  ```
  
###### Service Resolver

The service-resolver config entry kind controls which service instances should satisfy Connect upstream discovery requests for a given service name.

If no resolver config is defined the chain assumes 100% of traffic goes to the healthy instances of the default service in the current datacenter+namespace and discovery terminates.

See [here](https://www.consul.io/docs/agent/config-entries/service-resolver.html) for more details regarding available configuration settings and suggested usage.

`[consul_config: <entry>: config: config_entries : bootstrap:] <JSON list entry>` (**default**: [])
- specifies parameters that manage which service instances should satisfy Connect upstream discovery requests for a given service name

##### Example

 ```yaml
  consul_configs:
    - name: test-service-resolver
        path: /mnt/etc/consul.d
        config:
          config_entries:
            bootstrap:
              - Kind: service-resolver
                Name: example-api
                default_subset: v1
                subsets:
                  v1:
                    filter: "Service.Meta.version == v1"
                  v2:
                    filter: "Service.Meta.version == v2"
  ```
  
#### Launch

This role supports launching either a `consul` client or server agent utilizing the [systemd](https://www.freedesktop.org/wiki/Software/systemd/) service management tool, which manages the service as a background process or daemon subject to the configuration and execution potential provided by its underlying management framework.

_The following variables can be customized to manage the service's **systemd** [Service] unit definition and execution profile/policy:_

`extra_run_args: <consul-cli-options>` (**default**: `[]`)
- list of `consul` commandline arguments to pass to the binary at runtime for customizing launch.

Supporting full expression of `consul`'s [cli](https://www.consul.io/docs/agent/options.html#command-line-options), this variable enables the launch to be customized according to the user's specification.

`custom_unit_properties: <hash-of-systemd-service-settings>` (**default**: `[]`)
- hash of settings used to customize the `[Service]` unit configuration and execution environment of the *Consul* **systemd** service.

`go_exe_dir: </path/to/exe/dir>` (**default**: `<platform_dependent>`)
- path on target host where `go` binaries should be extracted to when `go_autoinstall` is enabled.

#### Uninstall

Support for uninstalling and removing artifacts necessary for provisioning allows for users/operators to return a target host to its configured state prior to application of this role. This can be useful for recycling node and perhaps providing more graceful/managed transitions between tooling upgrades.

_The following variable(s) can be customized to manage this uninstall process:_

`perform_uninstall: <true | false>` (**default**: `false`)
- whether to uninstall and remove all artifacts and remnants of this `consul` installation on a target host (**see**: `handlers/main.yml` for details)

Dependencies
------------

- 0x0i.systemd

Example Playbook
----------------
default example:
```
- hosts: all
  roles:
  - role: 0x0I.consul
```

install specific release version of archive containing pre-compiled binaries:
```
- hosts: consul-agents
  roles:
  - role: 0x0I.consul
    vars:
      install_type: archive
      archive_url: https://releases.hashicorp.com/consul/1.5.0/consul_1.5.0_linux_amd64.zip
      archive_checksum: 1399064050019db05d3378f757e058ec4426a917dd2d240336b51532065880b6
```

build and install target version from Git source:
```
- hosts: consul-agents
  roles:
  - role: 0x0I.consul
    vars:
      install_type: source
      git_version: v1.7.0-beta3
      go_autoinstall: true
```

enable server role and customize data storage directory:
```
- hosts: consul-servers
  roles:
  - role: 0x0I.consul
    vars:
      consul_configs:
        - name: server-cfg
          config:
            server: true
            data_dir: /mnt/data/consul
```

enable debug logging for troubleshooting:
```
- hosts: consul-canary
  roles:
  - role: 0x0I.consul
    vars:
      consul_configs:
        - name: consul-canary-cfg
          config:
            log_level: debug
            enable_debug: true
            log_file: /var/log/consul
            log_rotate_bytes: 1000000000
```

register consul clients within Consul service catalog 
 ```yaml
- hosts: my-host
  roles:
  - role: 0x0I.consul
    vars:
    consul_configs:
      - name: consul-agent
        # type: json
        # path: /etc/consul.d
        config:
          node_name: my-host.consul.agent
          server: false
          ui: true
          service:
            id: my-host.consul-agent.domain.net
            name: consul
            tags: ['dev']
            port: 8500
            enable_tag_override: false
            checks:
              - args: ["/usr/local/bin/check_consul.py"],
                interval: 10s
  ```

License
-------

MIT

Author Information
------------------

This role was created in 2019 by O1.IO.
