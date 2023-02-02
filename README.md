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

Manifested as `Dockerfiles`, `Helm charts`, `Ansible roles/collections` and `React/D3.js components`, built by **O1** and anyone else (+ a steadfast dedication rooted at the project's core to the latest and greatest tools involved in infrastructure automation, machine-learning and HCI), our infrastructure aims to literally elevate the idea of infrastructure providers to the :cloud: by building decentralized DevOps interfaces and platforms which provide evolved and sophisticated user-experiences pushing the boundary of the capabilities ofthe modern web; leaving behind the dark, archaic CLI and terminal days in the rearview.

# Operator

**Operator** is the first `User-Interface-as-a-Service (UIaaS)` software solution aimed at disrupting the way users interact with the myriad of open-source and proprietary services available on the web. Typically, the de facto interface used between users and these services is a command-line interface or CLI using terminal programs distributed across the major OS platforms (Windows, Mac, Linux). These types of interfaces are text-based, prone to typing errors, challenging to learn/remember, "noisy" by nature and overall considerably inefficient in terms of productivity when compared to more graphical user-interfaces.

<img src="https://miro.medium.com/max/786/1*4jGCY6YznCuRlYiLPaL27A.webp">

*Figure 1. example of a command-line interface*

**Operator** is a service that ultimately seeks to provide an extensible, web-based graphical user-interface which can serve as a proxy between how users visualize and manipulate the data and behaviors of each service while offering resource provisioning and productivity enhancing features such as installing and uninstalling applications, remembering and performing intellisense on commands, setting custom profiles and sharing operational insights/best practices with the world at large. It can be run from anywhere (locally or remote) and on any of the major OS platforms, exposed and accessed via HTTPS and can manage nodes using ONLY SSH and private-public key cryptography.

Checkout `v1` of the [REST API](https://github.com/0x0I/operator/tree/master/examples/v1) to **Get Started**!

# Applications

## O1labs.cloud

| role name | description|
| :---: | :---: |
| <img src="https://i.imgur.com/IBNz2CM.jpg"  width="25" height="25"> [operator](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/operator/README.md) | an open and decentralized managed infrastructure and operations service |
| <img src="https://developers.redhat.com/sites/default/files/styles/article_feature/public/blog/2015/01/docker-whale-home-logo.png?itok=nf2cLFMc"  width="25" height="25"> [base](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/base/README.md) | setup of basic virtualization and security system services supporting cloud-native infrastructure |
| <img src="https://code.benco.io/icon-collection/logos/ansible.svg"  width="25" height="25"> [ansible](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/ansible/README.md) | a software provisioning, configuration management and application-deployment tool |
| <img src="https://d7umqicpi7263.cloudfront.net/img/product/4c3eb104-ebd1-42be-9bd4-de25ef6918df/fd0db979-c8f1-4fbd-b900-fb2a15e19e6b.png"  width="25" height="25"> [consul](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/consul/README.md) | a service discovery, mesh and configuration control plane and networking tool |
| <img src="https://seeklogo.com/images/E/elasticsearch-logo-C75C4578EC-seeklogo.com.png"  width="25" height="25"> [elasticsearch](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/elasticsearch/README.md) | a real-time distributed search and analytics engine |
| <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTO8QjLQz_23H_dpfCmt6qDze_oIN-fZMbuaLfZbIZTp4bFrJ4M&s"  width="25" height="25"> [fluentd](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/fluentd/README.md) | a unified and scalable logging and data collection service |
| <img src="https://wiki.lafabriquedesmobilites.fr/images/fabmob/7/7d/Grafana_logo_swirl.png"  width="25" height="25"> [grafana](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/grafana/README.md) | an analytics and monitoring observability platform |
| <img src="https://www.servethehome.com/wp-content/uploads/2017/11/Redhat-logo.jpg"  width="25" height="25"> [journald](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/journald/README.md) | a system service which collects and stores logging data |
| <img src="https://pbs.twimg.com/profile_images/781633389577195521/kazUJooF_400x400.jpg"  width="25" height="25"> [kafka](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/kafka/README.md) | a distributed and fault tolerant stream-processing service |
| <img src="https://seeklogo.com/images/K/kibana-logo-3CB40921E7-seeklogo.com.png"  width="25" height="25"> [kibana](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/kibana/README.md) | an analytics and visualization platform designed to operate with Elasticsearch |
| <img src="https://uxwing.com/wp-content/themes/uxwing/download/web-app-development/ssh-icon.png"  width="25" height="25"> [openssh](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/openssh/README.md) | a remote login and operations tool based on the **SSH protocol** |
| <img src="https://i.imgur.com/mA5dAPk.png"  width="25" height="25"> [phoronix](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/phoronix/README.md) | a comprehensive & extensible testing and benchmarking platform for a range of hardware and machine subsystems |
| <img src="https://cdn.worldvectorlogo.com/logos/prometheus.svg"  width="25" height="25"> [prometheus](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/prometheus/README.md) | a multi-dimensional, non-distributed time-series database and monitoring/alerting toolkit |
| <img src="https://www.servethehome.com/wp-content/uploads/2017/11/Redhat-logo.jpg"  width="25" height="25"> [systemd](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/systemd/README.md) | system components and services managed by the Linux `systemd` system/service manager |
| <img src="https://d2eip9sf3oo6c2.cloudfront.net/tags/images/000/001/048/landscape/tmux.png"  width="25" height="25"> [tmux](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/tmux/README.md) | a terminal multiplexer enabling multiple terminals to be created, accessed, and controlled from a single screen |
| <img src="https://pbs.twimg.com/media/CcZdW37UcAA9DZz.png"  width="25" height="25"> [traefik](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/traefik/README.md) | a dynamic service reverse-proxy and load-balancer |
| <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Vimlogo.svg/767px-Vimlogo.svg.png"  width="25" height="25"> [vim](https://github.com/0x0I/operator/blob/master/ansible/O1labs/cloud/roles/vim/README.md) | a powerful and flexible text editor and development environment |

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
