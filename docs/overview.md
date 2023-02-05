# Project Overview and Design Specification

## What is O1?

### an open, decentralized software infrastructure platform (PaaS + IaaS) focused on supporting blockchain/web3 and cloud-native technologies
  - supports secure deployment of 10s of thousands of web3, cloud-native and devops applications leveraging available IaC solutions across major public and private [Ansible](https://galaxy.ansible.com/search?deprecated=false&keywords=&order_by=-relevance), [Container Image](https://hub.docker.com/search?q=) and [Helm](https://artifacthub.io/) repositories (including open-source standards or reference implementations developed by O1 Labs)
  - the O1 Labs IaC application offerings manage an SDLC (Software Deployment Lifecycle, in this case) from: **installation->configuration->launch->observability->uninstallation**
  - enables a computer hardware benchmarking platform and benchmark data marketplace based on the [Phoronix-Test-Suite](https://www.phoronix-test-suite.com/), [Ansible node fact gathering](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_vars_facts.html?extIdCarryOver=true&sc_cid=701f2000001OH7TAAW) and observability solutions like [Prometheus/Grafana](https://prometheus.io/docs/visualization/grafana/). 
  - lays the foundation for a decentralized computer/cloud infrastructure and managed service provider platform which empowers enthusiasts, entrepreneurs and professionals to leverage their compute resources and/or subject expertise to be compensated in exchange for services (think like AWS, GCP, Digital Ocean etc but completely open-source, decentralized, open to all types of applications & service providers and with ecosystem economics secured by the Ethereum blockchain)

### a decentralized open-source User-Interface-as-a-Service (UIaaS) platform

#### built to optimize the human-computer interface between the myriad of aforementioned software applications and technologies and all types of human users
  - currently supports a file and web-based interface which includes a REST API (Application Programming Interface) for observing and modifying application state and associated metadata
  - supports programmatic orchestration of these services and applications using any programming language
  - achieves parity with existing CLI tooling in that any CLI program can be executed securely against/on any controlled node with command output captured for processing
  - sets the stage for a modern web-based UI, perhaps built on top of React and d3.js, which supports a decentralized marketplace of community crafted user-interfaces which can be installed/uninstalled as easy as an iPhone/Android App
