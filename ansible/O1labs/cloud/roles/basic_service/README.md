<!-- @format -->

<p><img src="https://code.benco.io/icon-collection/logos/ansible.svg" alt="ansible logo" title="ansible" align="left" height="60" /></p>

# Basic-Service
[![Galaxy Role](https://img.shields.io/ansible/role/d/0x0i/basic_service)](https://galaxy.ansible.com/ui/standalone/roles/0x0i/basic_service/)
[![GitHub release (latest)](https://badgen.net/github/release/O1labs/basic-service)](https://github.com/O1labs/basic-service/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

Configure and operate a basic cloud-native service: running anything from web3 blockchain clients to the immense app store of open-source ([Apache](https://projects.apache.org/projects.html), [CNCF](https://landscape.cncf.io/?group=projects-and-products&view-mode=grid) and beyond) services.

## Requirements

`Systemd`, installation of the `docker` engine or a `Kubernetes` cluster.

## Role Variables

### Common

|       var       |                        description                         |     default      |
| :-------------: | :--------------------------------------------------------: | :--------------: |
|   _setup_mode_   |  infrastructure provisioning setup mode (`container, k8s, systemd, install`)  |   `undefined`    |
|     _name_      |                 name of service to deploy                  |    **required**    |
|     _command_     |             Command and arguments to execute on startup              |    **required**    |
|     _user_     |             service user to setup              |    `<operating-user>`    |
|     _group_     |             service group to setup              |    `<operating-user>`    |
|    _config_     |  configuration files associated with the service to mount  |       `{}`       |
|   _config_env_   |  environment variables to set within the service runtime   |       `{}`       |
|     _ports_     |          listening port information for a service          |       `{}`       |
|    _data_dirs_    |  directory mappings to store service runtime/operational data |      `{}`      |
|  _host_data_dir_  |   host directory for general deployment operations    |    ``    |
|     _cpus_      |  CPU resources each deployed service can use (either percentage for systemd or cores for containers)   |      `100`       |
|    _memory_     | available memory resources each deployed service can use |       `1G`       |
| _restart_policy_ |                  service restart policy                  | `on-failure` |
|   _uninstall_   |    whether to remove installed service and artifacts    |     `false`      |

### Container

|       var       |                        description                         |     default      |
| :-------------: | :--------------------------------------------------------: | :--------------: |
|     _image_     |             service container image to deploy              |    ` `    |
|     _network_mode_     |             container network to attach ([more info](https://docs.ansible.com/ansible/latest/collections/community/docker/docker_container_module.html#parameter-network_mode))              |    `bridge `    |
|     _binary_url_     |             URL of the binary file or archive to download and bind-mount into the container              |    ` `    |
|     _binary_file_name_override_     |             Override the binary file name after moving it to the destination directory              |    ` `    |
|    _binary_strip_components_     | Strip NUMBER leading components/directories from file names on extraction | `0` |
|     _destination_directory_     |             host directory where the binary file will be placed after downloading/extracting              |    `/usr/local/bin`    |
|     _binary_app_path_     |             in-container mount path for the downloaded binary directory              |    `<destination_directory>`    |

### Systemd

|       var       |                        description                         |     default      |
| :-------------: | :--------------------------------------------------------: | :--------------: |
|     _binary_url_     |             URL of the binary file to download              |    ` `    |
|     _binary_file_name_override_     |             Override the binary file name after moving it to the destination directory              |    ` `    |
|    _binary_strip_components_     | Strip NUMBER leading components/directories from file names on extraction | `0` |
|     _destination_directory_     |             directory where the binary file will be placed after downloading/extracting              |    `/usr/local/bin`    |
|   _systemd_   |    custom service type & unit, service and install properties    |     `{}`      |
|   _systemd.enable_accounting_   |    enable systemd resource accounting (CPU, Memory, IO, Tasks, IP)    |     `true`      |

### Kubernetes (k8s)

To authorize access to the target Kubernetes cluster, set the following environment variables:
```bash
export KUBECONFIG=<path-to-the-kubeconfig-file>
export KUBE_CONTEXT=<context-within-the-kubeconfig-to-use>
```

|       var       |                        description                         |     default      |
| :-------------: | :--------------------------------------------------------: | :--------------: |
|     _helm_chart_path_     |             path to Helm chart to use for the service deployment/release              |    `helm` (resolved relative to the role)    |
|     _helm_namespace_      |  Kubernetes namespace to deploy to (also rendered into chart values)   |      `default`       |
|    _helm_values_path_     | optional Helm values overlay file merged after rendered role values |       `""`       |
| _helm_render_values_from_role_ | map common role vars (`image`, `config`, `ports`, `cpus`, `memory`, etc.) into Helm values | `true` |
| _helm_create_namespace_ | create the target namespace during Helm install | `true` |
| _helm_wait_ / _helm_atomic_ / _helm_timeout_ | Helm install safety controls | `true` / `true` / `10m` |

With `setup_mode: k8s`, the role renders Helm values from the same variables used by `container`, `systemd`, and `install` modes, then deploys the bundled chart. Set `helm_render_values_from_role: false` to use only `helm_values_path`.

## Containerized Apps
- [O1 Containers](https://github.com/O1labs/containers)
- [Dockerhub](https://hub.docker.com/search?q=)
- [Quay.io](https://quay.io/search)

## Dependencies

Install role and collection requirements:

```bash
ansible-galaxy install -r requirements.yml
```

See [requirements.yml](./requirements.yml) for the full list (includes `ansible-role-systemd` and `community.docker`).

## Example Playbook

One schema for `container`, `systemd`, `k8s`, and `install` — swap `setup_mode`; the role derives mounts, ports, firewall rules, unit files, and Helm values from shared dicts.

*Molecule CI: [tests/molecule/](./tests/molecule/).*

### Container

```yaml
- name: Serve nginx
  hosts: web
  become: true
  roles:
    - role: o1labs.cloud.basic_service
      vars:
        setup_mode: container
        name: nginx
        image: nginx:latest
        command: nginx -g "daemon off;"
        cpus: 0.5
        memory: 128M
        ports:
          http:
            ingressPort: 8080
            servicePort: 80
```

### Prometheus — systemd or k8s

Play `vars` and a YAML anchor share config across runtimes. For k8s, set `KUBECONFIG` / `KUBE_CONTEXT` ([Kubernetes variables](#kubernetes-k8s)).

```yaml
- name: Prometheus on systemd
  hosts: monitoring
  become: true
  vars:
    prometheus_root: /var/lib/prometheus
    prometheus_data_dir: "{{ prometheus_root }}/data"
    prometheus_config: /etc/prometheus/prometheus.yml
    prometheus: &prometheus
      name: prometheus
      memory: 512M
      ports:
        prometheus: { ingressPort: 9090, servicePort: 9090 }
      config:
        prometheus.yml:
          destinationPath: "{{ prometheus_config }}"
          data: |
            global:
              scrape_interval: 15s
            scrape_configs:
              - job_name: prometheus
                static_configs:
                  - targets: ["localhost:9090"]
  roles:
    - role: o1labs.cloud.basic_service
      vars:
        <<: *prometheus
        setup_mode: systemd
        user: prometheus
        cpus: 50
        binary_url: https://github.com/prometheus/prometheus/releases/download/v2.47.0/prometheus-2.47.0.linux-amd64.tar.gz
        binary_strip_components: 1
        binary_file_name_override: "{{ name }}"
        command: >
          /usr/local/bin/{{ name }}
          --config.file={{ prometheus_root }}{{ prometheus_config }}
          --storage.tsdb.path={{ prometheus_data_dir }}
        host_data_dir: "{{ prometheus_root }}"
        data_dirs:
          prometheus_data:
            hostPath: "{{ prometheus_data_dir }}"
            appPath: "{{ prometheus_data_dir }}"
        setup_iptables: true
        systemd:
          enable_accounting: true

- name: Prometheus on Kubernetes
  hosts: localhost
  connection: local
  roles:
    - role: o1labs.cloud.basic_service
      vars:
        <<: *prometheus
        setup_mode: k8s
        image: prom/prometheus:v2.47.0
        helm_namespace: monitoring
        cpus: 0.5
        command: >
          --config.file={{ prometheus_config }}
          --storage.tsdb.path=/prometheus
        k8s_health_check_path: /-/healthy
```

### Ethereum (Sepolia)

```yaml
- name: Ethereum Sepolia stack
  hosts: sepolia_nodes
  become: true
  vars:
    ethereum_network: sepolia
    ethereum_data_root: /var/lib/ethereum
    jwt_path: "{{ ethereum_data_root }}/jwt.hex"
    ethereum_client: &ethereum_client
      setup_mode: systemd
      user: ethereum
  roles:
    - role: o1labs.cloud.basic_service
      vars:
        <<: *ethereum_client
        name: reth
        host_data_dir: "{{ ethereum_data_root }}/{{ name }}"
        client_datadir: "{{ ethereum_data_root }}/{{ name }}/data"
        binary_url: https://github.com/paradigmxyz/reth/releases/download/v1.1.4/reth-v1.1.4-x86_64-unknown-linux-gnu.tar.gz
        binary_file_name_override: "{{ name }}"
        command: >
          /usr/local/bin/{{ name }} node --chain {{ ethereum_network }}
          --datadir {{ client_datadir }}
          --authrpc.jwtsecret {{ jwt_path }}
          --http --http.addr 127.0.0.1 --http.port 8545
          --metrics 0.0.0.0:9001
        cpus: 80
        memory: 8G
        data_dirs:
          chain:
            hostPath: "{{ client_datadir }}"
            appPath: "{{ client_datadir }}"
        ports:
          metrics: { ingressPort: 9001, servicePort: 9001 }

    - role: o1labs.cloud.basic_service
      vars:
        <<: *ethereum_client
        name: lighthouse
        host_data_dir: "{{ ethereum_data_root }}/{{ name }}"
        client_datadir: "{{ ethereum_data_root }}/{{ name }}/data"
        binary_url: https://github.com/sigp/lighthouse/releases/download/v6.0.0/lighthouse-v6.0.0-x86_64-unknown-linux-gnu.tar.gz
        binary_file_name_override: "{{ name }}"
        command: >
          /usr/local/bin/{{ name }} bn --network {{ ethereum_network }}
          --datadir {{ client_datadir }}
          --checkpoint-sync-url https://checkpoint-sync.sepolia.ethpandaops.io
          --execution-endpoint http://127.0.0.1:8551
          --execution-jwt {{ jwt_path }}
          --http --http-address 127.0.0.1 --http-port 5052
          --metrics --metrics-address 0.0.0.0 --metrics-port 9002
        cpus: 50
        memory: 4G
        data_dirs:
          beacon:
            hostPath: "{{ client_datadir }}"
            appPath: "{{ client_datadir }}"
        ports:
          metrics: { ingressPort: 9002, servicePort: 9002 }
```

### Install / uninstall

```yaml
- name: Install jq CLI
  hosts: all
  become: true
  vars:
    jq_tool: &jq_tool
      setup_mode: install
      name: jq
      binary_url: https://github.com/jqlang/jq/releases/download/jq-1.7.1/jq-linux-amd64
      binary_file_name_override: "{{ name }}"
  roles:
    - role: o1labs.cloud.basic_service
      vars:
        <<: *jq_tool

- name: Remove jq CLI
  hosts: all
  become: true
  roles:
    - role: o1labs.cloud.basic_service
      vars:
        <<: *jq_tool
        uninstall: true
```

## License

MIT

## Author Information

This Ansible role was created in 2023 by O1.IO.

🏆 **always happy to help & donations are always welcome** 💸

- **ETH (Ethereum):** 0x781C5564c9B350db11171E06a09b2361CC6756c2

- **BTC (Bitcoin):** bc1qx6fa4hqz6nhc0put3rhzsk58nue7zpufpkhd6e

- **SOL (Solana):** 2UzF9wxhPSQMeL6DabQJ8Eq3q5wUBnf4Yp4LuJCWSD1J
