# Project Overview and Design Specification

## What is O1?

### an open, decentralized software infrastructure platform (PaaS + IaaS) focused on supporting blockchain/web3 and cloud-native technologies
  - supports deployment of 10s of thousands of web3, cloud-native and DevOps applications leveraging available IaC solutions across major public and private [Ansible](https://galaxy.ansible.com/search?deprecated=false&keywords=&order_by=-relevance), [Container Image](https://hub.docker.com/search?q=) and [Helm](https://artifacthub.io/) repositories
  - the O1 Labs application offerings provide an SDLC (Software Deployment Lifecycle, in this case) from: **installation->configuration->launch->observability->uninstallation**
  - the platform supports virtualized/containerized (Docker/Kubernetes) deployments or deploying stand-alone binaries using Systemd
  - applications are securely deployed and operated using the SSH protocol and either password authentication or public-private key cryptography
  - lays the foundation for a decentralized compute/cloud infrastructure and managed service provider which empowers enthusiasts, entrepreneurs and professionals to leverage and offer their compute resources and/or subject expertise in exchange for compensation (think like AWS, GCP, Azure, Digital Ocean etc but completely open-source and decentralized, open to all types of applications & service providers and *with ecosystem economics secured by the Ethereum blockchain and governed by DAOs*)
  - enables a computer hardware benchmarking platform and benchmark data marketplace based on the [Phoronix-Test-Suite](https://www.phoronix-test-suite.com/), [Ansible node fact gathering](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_vars_facts.html?extIdCarryOver=true&sc_cid=701f2000001OH7TAAW) and observability solutions like [Prometheus/Grafana](https://prometheus.io/docs/visualization/grafana/) and [OpenBenchmarking.org](https://openbenchmarking.org/) which can serve as the basis for compute resource and managed service pricing models

### a User-Interface-as-a-Service (UIaaS) platform

#### built to optimize the human-computer interface between the myriad of aforementioned software applications and technologies and human users
  - a terminal and CLI replacement
  - currently supports a file and web-based interface which includes a REST API (Application Programming Interface) for observing and modifying application state and associated metadata
  - supports programmatic orchestration of these services and applications using any programming language
  - the REST API can be accessed via HTTP (by default) or HTTPs utilizing Let's Encrypt
  - achieves parity with existing CLI tooling in that any CLI program can be executed securely on any operated node with command output captured for processing
  - sets the stage for a modern web-based UI, perhaps built on top of React and d3.js, which supports a decentralized marketplace of community crafted user-interfaces which can be installed/uninstalled as easy as an iPhone/Android App
