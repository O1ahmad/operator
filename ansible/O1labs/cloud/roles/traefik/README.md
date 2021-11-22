<p><img src="https://code.benco.io/icon-collection/logos/ansible.svg" alt="ansible logo" title="ansible" align="left" height="60" /></p>
<p><img src="https://pbs.twimg.com/media/CcZdW37UcAA9DZz.png" alt="traefik logo" title="traefik" align="right" height="60" /></p>

Ansible Role :clapper: :twisted_rightwards_arrows: Traefik
=========
[![Galaxy Role](https://img.shields.io/ansible/role/46109.svg)](https://galaxy.ansible.com/0x0I/traefik)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/0x0I/ansible-role-traefik?color=yellow)
[![Downloads](https://img.shields.io/ansible/role/d/46109.svg?color=lightgrey)](https://galaxy.ansible.com/0x0I/traefik)
[![Build Status](https://travis-ci.org/0x0I/ansible-role-traefik.svg?branch=master)](https://travis-ci.org/0x0I/ansible-role-traefik)
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

Ansible role that installs and configures Traefik: a dynamic service reverse-proxy and load-balancer.

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

`traefik_user: <service-user-name>` (**default**: *traefik*)
- dedicated service user and group used by `traefik` for privilege separation (see [here](https://www.beyondtrust.com/blog/entry/how-separation-privilege-improves-security) for details)

`install_type: <archive>` (**default**: archive)
- **archive**: currently compatible with both **tar and zip** formats, installation of Traefik via compressed archives results in the direct download of its component binaries, consisting of the `traefik` proxy server.

  **note:** archived installation binaries can be obtained from the official [releases](https://github.com/containous/traefik/releases) site or those generated from development/custom sources.

`install_dir: </path/to/installation/dir>` (**default**: `/opt/traefik`)
- path on target host where the `traefik` binaries should be extracted to.

`archive_url: <path-or-url-to-archive>` (**default**: see `defaults/main.yml`)
- address of a compressed **tar or zip** archive containing `traefik` binaries. This method technically supports installation of any available version of `traefik`. Links to official versions can be found [here](https://github.com/containous/traefik/releases).

`archive_checksum: <path-or-url-to-checksum>` (**default**: see `defaults/main.yml`)
- address of a checksum file or actual checksum for verifying the data integrity of the specified archive. While recommended and generally considered a best practice, specifying a checksum is *not required* and can be disabled by providing an empty string (`''`) for its value.

`checksum_format: <string>` (**default**: see `sha512`)
- hash algorithm used for file verification associated with the specified archive checksum. Reference [here](https://en.wikipedia.org/wiki/Cryptographic_hash_function) for more information about *checksums/cryptographic* hashes.

`archive_options: <untar-or-unzip-options>` (**default**: `[]`)
- list of additional unarchival arguments to pass to either the `tar` or `unzip` binary at runtime for customizing how the archive is extracted to the designated installation directory. See [man tar](https://linux.die.net/man/1/tar) and [man unzip](https://linux.die.net/man/1/unzip) for available options to specify, respectively.

#### Config

Traefik supports specification of multiple routing and load-balancing configuration files or definitions for controlling various aspects of an agent's behavior. These definitions are expected to be expressed in either `YAML` or `TOML` format and to adhere to the syntax framework and rules outlined in *Traefik's* official docs and as determined by the community.

Each of these configurations can be expressed using the `traefik_configs` hash, which contains a list of various Traefik agent configuration options:
* entrypoints
* routers
* middlewares
* services
* providers

Each hash is composed of structures specific to each configuration type for declaring the desired agent settings to be rendered in addition to common amongst them all, `:name, :path and :config`, which specify the name and path of the configuration file in addition to the configuration itself to render.

See [here](https://docs.traefik.io/routing/overview/) for more details as well as a list of supported options for each configuration type and reference the following for a more in-depth explanation in addition to examples of each.

`[traefik_configs: <entry>:] name: <string>` (**default**: *required*)
- name of the configuration file to render on the target host (excluding the file extension)

`[traefik_configs: <entry>:] type: <yaml|toml>` (**default**: *yaml*)
- type or format of the configuration file to render. Currently only `YAML` is supported.

`[traefik_configs: <entry>:] path: </path/to/config>` (**default**: */etc/traefik*)
- path of the configuration file to render on the target host

`[traefik_configs: <entry>:] config: <JSON>` (**default**: )
- specifies parameters that manage various aspects of a traefik agent's operations

[Reference here](https://docs.traefik.io/reference/static-configuration/file/) for a list of supported configuration options.

###### Example

 ```yaml
  traefik_configs:
    - name: example-config
      path: /example/path
      config:
        global:
          checkNewVersion: true
          sendAnonymousUsage: true
        api:
          insecure: true
          dashboard: true
          debug: true
  ```
  
##### Entrypoints

A part of what is termed as Traefik's "static configuration", entryPoints are the network entry points into Traefik. They define the port which will receive the requests (whether HTTP or TCP). Most of what happens to the connection between the clients and Traefik, and then between Traefik and the backend servers, is configured through the entrypoints in addition to routers.

See [here](https://docs.traefik.io/routing/entrypoints/) for more details regarding these options and suggestions on their usage.

`[traefik_configs: <entry>: config: entrypoints:] <YAML>` (**default**: )
- specifies parameters that manage Traefik entrypoint registration

###### Example

 ```yaml
  traefik_configs:
    - name: example-entrypoint
      # type: yaml
      # path: /etc/traefik
      config:
        entryPoints:
          web:
            address: ":80"
          websecure:
            address: ":443"
  ```
  
##### Routers

A router is in charge of connecting incoming requests to the services that can handle them. In the process, routers may use pieces of middleware to update the request, or act before forwarding the request to the service.

See [here](https://docs.traefik.io/routing/routers/) for more details regarding these options and suggestions on their usage.

`[traefik_configs: <entry>: config: <http|tcp>: routers] <YAML>` (**default**: )
- specifies parameters that manage Traefik router registration

###### Example

 ```yaml
  traefik_configs:
    - name: example-router
      config:
        http:
          routers:
            my-router:
              rule: "Path(`/foo`)"
              service: service-foo
  ```
  
##### Middlewares

Attached to the routers, pieces of middleware are a means of tweaking the requests before they are sent to your service (or before the answer from the services are sent to the clients). There are several available middleware in Traefik, some can modify the request, the headers, some are in charge of redirections, some add authentication, and so on.

Pieces of middleware can be combined in chains to fit every scenario.

See [here](https://docs.traefik.io/middlewares/overview/) for more details regarding these options and suggestions on their usage.

`[traefik_configs: <entry>: config: <http|tcp>: middlewares] <YAML>` (**default**: )
- specifies parameters that manage Traefik middleware registration

###### Example

 ```yaml
  traefik_configs:
    - name: example-middleware
      config:
        http:
          routers:
            router1:
              service: myService
              middlewares:
                - "foo-add-prefix"
              rule: "Host(`example.com`)"
          middlewares:
            foo-add-prefix:
              addPrefix:
                prefix: "/foo"
  ```
  
##### Services

Services are responsible for configuring how to reach the actual services that will eventually handle the incoming requests. Nested load balancers are able to load balance the requests between multiple instances of your services.

See [here](https://docs.traefik.io/routing/services/) for more details regarding available configuration settings and suggested usage.

`[traefik_configs: <entry>: config: <http|tcp>: services] <YAML>` (**default**: )
- specifies parameters that manage Traefik service registration

###### Example

 ```yaml
  traefik_configs:
    - name: example-service
      config:
        http:
          services:
            my-service:
              loadBalancer:
                servers:
                - url: "http://private-ip-server-1/"
                - url: "http://private-ip-server-2/"
  ```

##### Providers

Configuration discovery in Traefik is achieved through Providers. The providers are existing infrastructure components, whether orchestrators, container engines, cloud providers, or key-value stores. The idea is that Traefik will query the providers' API in order to find relevant information about routing, and each time Traefik detects a change, it dynamically updates the routes.

Traefik providers are categorized according to the following 4 groups:
* Label based (each deployed server/container has a set of labels attached to it)
* Key-Value based (each deployed server/container updates a key-value store with relevant information)
* Annotation based (a separate object, with annotations, defines the characteristics of the server/container)
* File based (the good old configuration file)

See [here](https://docs.traefik.io/providers/overview/#supported-providers) for a list of supported providers and more details regarding available configuration settings and suggested usage.

`[traefik_configs: <entry>: config: providers] <YAML>` (**default**: )
- specifies parameters that manage Traefik provider registration

###### Example

 ```yaml
  traefik_configs:
    - name: example-provider
      config:
        providers:
          consulCatalog:
            endpoint:
              address: http://127.0.0.1:8500
              # ...
  ```
  
#### Launch

This role supports launching a `traefik` server proxy utilizing the [systemd](https://www.freedesktop.org/wiki/Software/systemd/) service management tool, which manages the service as a background process or daemon subject to the configuration and execution potential provided by its underlying management framework.

_The following variables can be customized to manage the service's **systemd** [Service] unit definition and execution profile/policy:_

`extra_run_args: <traefik-cli-options>` (**default**: `[]`)
- list of `traefik` commandline arguments to pass to the binary at runtime for customizing launch.

Supporting full expression of `traefik`'s [cli](https://docs.traefik.io/reference/static-configuration/cli/) and, subsequently the full set of configuration options as referenced and described above, this variable enables the launch to be customized according to the user's exact specification.

`custom_unit_properties: <hash-of-systemd-service-settings>` (**default**: `[]`)
- hash of settings used to customize the `[Service]` unit configuration and execution environment of the *Traefik* **systemd** service.

#### Uninstall

`perform_uninstall: <true | false>` (**default**: `false`)
- whether to uninstall and remove all artifacts and remnants of this `traefik` installation on a target host (**see**: `handlers/main.yml` for details)

Dependencies
------------

- 0x0i.systemd

Example Playbook
----------------
default example:
```
- hosts: all
  roles:
  - role: 0x0I.traefik
```

download and install specific version of Traefik binaries:
```
- hosts: all
  roles:
  - role: 0x0I.traefik
    vars:
      install_type: archive
      archive_url: https://github.com/containous/traefik/releases/download/v2.1.4/traefik_v2.1.4_linux_amd64.tar.gz
      archive_checksum: a0023d3b01c881cffc89b5b69d51d8e86d4e9ac87e87d57a9029731a83780893
```

enable debug logging for troubleshooting purposes:
```
- hosts: all
  roles:
  - role: 0x0I.traefik
    vars:
      traefik_configs:
        - name: log-settings
          config:
            log:
              level: DEBUG
              filePath: /var/log/traefik/traefik.log
              format: json
            accessLog:
              filePath: /var/log/traefik/access.log
              format: json
              bufferingSize: 100
              filters:
                statusCodes:
                - 500-511
                - 400-451
                - 308
              retryAttempts: true
              minDuration: 10ms
```

enable Prometheus metrics collection and reporting:
```
- hosts: all
  roles:
  - role: 0x0I.traefik
    vars:
      traefik_configs:
        - name: prometheus-metrics
          config:
            entryPoints:
              metrics:
                address: ":8082"
            metrics:
              prometheus:
                entryPoint: metrics
                addEntryPointsLabels: true
                addServicesLabels: true
                buckets:
                  - 0.1
                  - 0.3
                  - 1.2
                  - 5.0
```

configure Consul provider:
```
- hosts: all
  roles:
  - role: 0xOI.traefik
    vars:
      traefik_configs:
        - name: consul-provider
          config:
           providers:
             consulCatalog:
               stale: false
               cache: true
               exposedByDefault: false
               endpoint:
                 address: https://127.0.0.1:8500
                 scheme: https
                 datacenter: staging
               tls:
                 ca: path/to/ca.crt
                 caOptional: true
                 cert: path/to/foo.cert
                 key: path/to/foo.key
                 insecureSkipVerify: true
```

activate Jaeger tracing:
```
- hosts: all
  roles:
  - role: 0x0I.traefik
    vars:
      traefik_configs:
        - name: jaeger-tracing
          config:
            tracing:
              jaeger:
                samplingServerURL: http://localhost:5778/sampling
                samplingType: const
                samplingParam: 1.0
                localAgentHostPort: 127.0.0.1:6831
                gen128Bit: true
                traceContextHeaderName: example-trace-id
                endpoint: http://127.0.0.1:14268/api/traces?format=jaeger.thrift
```

License
-------

MIT

Author Information
------------------

This role was created in 2020 by O1.IO.
