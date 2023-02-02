<p><img src="https://i.imgur.com/IBNz2CM.jpg" alt="0xO1 logo" title="0xO1" align="right" height="80" /></p>

🌎 O1 Labs
=========
![GitHub release (latest by date)](https://img.shields.io/github/v/release/0x0I/operator?color=yellow)
[![0x0I](https://circleci.com/gh/0x0I/operator.svg?style=svg)](https://circleci.com/gh/0x0I/operator)
[![Docker Pulls](https://img.shields.io/docker/pulls/0labs/operator?style=flat)](https://hub.docker.com/repository/docker/0labs/operator)
[![License: MIT](https://img.shields.io/badge/License-MIT-blueviolet.svg)](https://opensource.org/licenses/MIT)

**in·fra·struc·ture/ˈinfrəˌstrək(t)SHər/**

    1. the basic physical and organizational structures and facilities (e.g. buildings, roads, power supplies) needed for the operation of a society or enterprise.

*O1 Labs is an open, decentralized and managed infrastructure/operations service platform dedicated to the development, provisioning and support of ALL things cloud-native and web3.*

Ranging from cloud-native services/applications (e.g. `prometheus, kafka, fluentd`) to blockchain network nodes and validators to an assortment of development and operational environments (e.g. `git, vim, tmux`), **O1** strives to enhance all technological ecosystems with encoded expert & experienced operational logic and insights via the most established and developed software automation tools, human-computer vizualization and interaction technques and best practices - crafted and curated by a world-wide community of researchers, developers, operators and hobbyists/enthusiasts.

Manifested as Dockerfiles, Helm charts, Ansible roles/collections and React/D3.js components, built by O1 and everyone else (+ a steadfast dedication rooted at the project's core to the latest and greatest tools involved in infrastructure automation, machine-learning and HCI), our infrastructure aims to literally escalate the idea of infrastructure providers to the :cloud: by building decentralized DevOps interfaces and platforms which provide evolved and sophisticated user-experiences pushing the boundary of the capabilities ofthe modern web; leaving behind the dark, archaic CLI and terminal days in the rearview.

# Applications

## O1labs.cloud

| role name | description|
| :---: | :---: |
| [operator](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/operator/README.md) | an open and decentralized managed infrastructure and operations service |
| [base](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/base/README.md) | setup of basic virtualization and security system services supporting cloud-native infrastructure |
| [ansible](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/ansible/README.md) | a software provisioning, configuration management and application-deployment tool |
| [consul](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/consul/README.md) | a service discovery, mesh and configuration control plane and networking tool |
| [elasticsearch](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/elasticsearch/README.md) | a real-time distributed search and analytics engine |
| [fluentd](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/fluentd/README.md) | a unified and scalable logging and data collection service |
| [grafana](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/grafana/README.md) | an analytics and monitoring observability platform |
| [journald](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/journald/README.md) | a system service which collects and stores logging data |
| [kafka](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/kafka/README.md) | a distributed and fault tolerant stream-processing service |
| [kibana](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/kibana/README.md) | an analytics and visualization platform designed to operate with Elasticsearch |
| [openssh](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/openssh/README.md) | a remote login and operations tool based on the **SSH protocol** |
| [phoronix](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/phoronix/README.md) | a comprehensive & extensible testing and benchmarking platform for a range of hardware and machine subsystems |
| [prometheus](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/prometheus/README.md) | a multi-dimensional, non-distributed time-series database and monitoring/alerting toolkit |
| [systemd](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/systemd/README.md) | system components and services managed by the Linux `systemd` system/service manager |
| [tmux](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/tmux/README.md) | a terminal multiplexer enabling multiple terminals to be created, accessed, and controlled from a single screen |
| [traefik](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/traefik/README.md) | a dynamic service reverse-proxy and load-balancer |
| [vim](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/vim/README.md) | a powerful and flexible text editor and development environment |

## O1labs.crypto

| name | description|
| :---: | :---: |
| <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Ethereum-icon-purple.svg/1200px-Ethereum-icon-purple.svg.png"  width="25" height="25"> [geth](https://github.com/0x0I/operator/blob/master/ansible/O1labs/crypto/roles/geth/README.md) | an Ethereum blockchain client written in Go |
| [<img src="https://openethereum.github.io/images/logo-openethereum.svg"  width="75" height="75">](https://github.com/0x0I/operator/blob/master/ansible/O1labs/crypto/roles/openethereum/README.md) | a fast and feature-rich multi-network Ethereum client |
| [<img src="https://cryptomode.com/wp-content/uploads/2020/08/CryptoMode-chainLink-Price-696x392.jpg"  width="100" height="75">](https://github.com/0x0I/operator/blob/master/ansible/O1labs/crypto/roles/chainlink/README.md) | a smart-contract platform data oracle network |
| <img src="https://prysmaticlabs.com/assets/PrysmStripe.png"  width="25" height="25"> [prysm](https://github.com/0x0I/operator/blob/master/ansible/O1labs/crypto/roles/prysm/README.md) | A full-featured client for the Ethereum 2.0 protocol, written in Go |
| <img src="https://miro.medium.com/max/300/1*76dYSeZfdwypV1bzlwPivg.gif"  width="25" height="25"> [lighthouse](https://github.com/0x0I/operator/blob/master/ansible/O1labs/crypto/roles/lighthouse/README.md) | an Ethereum 2.0 client, written in Rust and maintained by Sigma Prime |
| <img src="https://pbs.twimg.com/profile_images/1324063968877563907/n-NYkVty.png"  width="25" height="25"> [teku](https://github.com/0x0I/operator/blob/master/ansible/O1labs/crypto/roles/teku/README.md) | an open-source Ethereum 2.0 client written in Java |
| <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRe7lR0_OVIJM3kQbeUpBnaSTEpBKpQJcD-CidXalDT8g&s" width="25" height="25"> [lotus](https://github.com/0x0I/operator/blob/master/ansible/O1labs/crypto/roles/lotus/README.md) | a Go-implementation of the Filecoin distributed storage network blockchain protocol |
| <img src="https://icodrops.com/wp-content/uploads/2018/05/Mina_logo-150x150.png" width="25" height="25"> [mina](https://github.com/0x0I/operator/blob/master/ansible/O1labs/crypto/roles/mina/README.md) | client nodes a part of Mina's succinct zero-knowledge protocol based on recursive composition of zk-SNARKs |
| <img src="https://previews.123rf.com/images/viktorijareut/viktorijareut1710/viktorijareut171000267/90109811-zcash-crypto-currency-block-chain-flat-logo.jpg" width="25" height="25"> [zcash](https://github.com/0x0I/operator/blob/master/ansible/O1labs/crypto/roles/zcash/README.md) | a client for the Zcash zero-knowledge privacy blockchain/protocol |
