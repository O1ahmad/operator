<p><img src="https://code.benco.io/icon-collection/logos/ansible.svg" alt="ansible logo" title="ansible" align="left" height="60" /></p>
<p><img src="https://mpng.pngfly.com/20180417/ksq/kisspng-secure-shell-ssh-keygen-computer-servers-computer-shell-5ad620b8944a73.5640200315239825206074.jpg" alt="openssh logo" title="openssh" align="right" height="60" /></p>

Ansible Role :closed_lock_with_key: OpenSSH
=========
[![Galaxy Role](https://img.shields.io/ansible/role/44128.svg)](https://galaxy.ansible.com/0x0I/openssh)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/0x0I/ansible-role-openssh?color=yellow)
[![Downloads](https://img.shields.io/ansible/role/d/44128.svg?color=lightgrey)](https://galaxy.ansible.com/0x0I/openssh)
[![Build Status](https://travis-ci.org/0x0I/ansible-role-openssh.svg?branch=master)](https://travis-ci.org/0x0I/ansible-role-openssh)
[![License: MIT](https://img.shields.io/badge/License-MIT-blueviolet.svg)](https://opensource.org/licenses/MIT)

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
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
<!-- END doctoc generated TOC please keep comment here to allow auto update -->

Ansible role that installs, configures and runs [OpenSSH](https://www.openssh.com/): a remote login and operations tool based on the **SSH protocol**.

##### Supported Platforms:
```
* Debian
* Redhat(CentOS/Fedora)
* Ubuntu
```

Requirements
------------

Pre-installation of a C-compiler (any C89 or better compiler should work) as well as working installations of both the **zlib** and **libcrypto** libraries (included within *LibreSSl/OpenSSL*) are required. A C compiler is generally available on supported platforms/linux distributions by default but can be downloaded using each platforms' native package manager if necessary. [Reference](https://gcc.gnu.org/wiki/InstallingGCC) for additional details.

**Zlib** version 1.1.4, 1.2.1.2 or greater is suggested (see https://zlib.net/fossils/ for released versions).

Also note that newer versions of *OpenSSH* require or strongly encourage a dedicated authentication account used by `sshd` for privilege separation. This is automatically managed by this role and configurable via custom operator vars.

Role Variables
--------------
Variables are available and organized according to the following software & machine provisioning stages:
* _install_
* _config_
* _launch_
* _uninstall_

### Install

`openssh`can be installed using OS package management systems provided by the supported platforms (e.g `apt`, `yum/dnf`).

_The following variables can be customized to control various aspects of this installation process, ranging from the package version and user to run the SSH service as to the automatic setup of an SSH key caching agent (`ssh-agent`):_

`service_package: <package-name-and-version>` (**default**: *openssh*[-latest])
- name and version of the openssh package to download and install. [Reference](http://fr2.rpmfind.net/linux/rpm2html/search.php?query=openssh) or run something like `dnf --showduplicates list openssh` in a terminal to display a list of available packages for your platform

`auto_enable_agent: <hash-of-accounts-to-enable>` (**default**: *None*)
- indicates user accounts to install and automatically enable a user-scoped instance of `ssh-agent`, managed by systemd. Hash contains `run_args` key for customization of agent launch

#### Example

 ```yaml
  auto_enable_agent:
    # users
    example-1: {}
    example-2:
       # launch ssh-agent in debug mode with key TTL of 1 hour
       run_args: "-d -t 3600"
  ```

### Config

Using this role, configuration of an `openssh` installation is organized according to the following components:

* service (`sshd_config`)
* client (`ssh_config`)
* known hosts (`ssh_known_hosts #global` and `known_hosts #per-user`)
* authorized keys (`authorized_keys`)
* user identities (e.g. `id_rsa #private-key` and `id_rsa.pub #public-key`)

The set of component configurations to manage can be controlled using the `managed_configs` list var:

`managed_configs: <list-of-component-configs>` (**default**: ALL *see defaults/main.yml*)
- list of SSH components' configuration to manage via this role

Each configuration can be expressed within a hash, keyed by user account where appropriate. The value of these user account keys are generally dicts representing config specifications (e.g. an entry in a user's authorized_keys file granting access to the local account for a particular key) containing a set of key-value pairs constituting associated settings for each component. The following provides an overview and example configuration of each for reference.

#### Service

SSH daemon configuration values are defined under `ssh_config.service` and describe a service config specification to be rendered at the appropriate location (i.e. `/etc/ssh/sshd_config`):

`[ssh_config:] service: <key: value,...>` (**default**: see `defaults/main.yml`)
- a list of available configuration options can be found [here](https://man.openbsd.org/sshd_config)

##### Example

 ```yaml
  ssh_config:
    service:
      # disable password and challenge-response authentication methods and enable Public-Key auth *ONLY*
      PasswordAuthentication: "no"
      ChallengeResponseAuthentication: "no"
      PubKeyAuthentication: "yes"
  ```

#### Client

SSH client configuration values are defined under `ssh_config.client` and describe client config specifications, from both a global and per-user scope, to be rendered at the appropriate locations (i.e. `/etc/ssh/ssh_config # global` and `~/.ssh/config` # per-user).

_**Each specification contains a keyword attribute to describe whether the config is anchored on a `Host (default)` or `Match` basis:**_

`[ssh_config: client : {global | user-account} : {entry} :] keyword: <Host | Match>` (**default**: *Host*)
- entry match basis (reference [here](https://man.openbsd.org/sshd_config) for more details)

`[ssh_config: client : {global | user-account} : {entry} :] options: <key: value,...>` (**default**: see `defaults/main.yml`)
- a list of available configuration options can be found [here](https://man.openbsd.org/ssh_config)

##### Example

 ```yaml
  ssh_config:
    client:
        # system-wide settings
        global:
          '*':
            options:
              # disable auto add and forwarding of user keys by an `ssh-agent`
              AddKeysToAgent: 'no'
              ForwardAgent: 'no'
        # custom settings for user-account-1
        user-account-1:
          # add and forward keys on connections to machines with the hostname matching dev-user.dev.net
          'host "dev-user.dev.net"':
            keyword: "Match"
            options:
              AddKeysToAgent: 'yes'
              ForwardAgent: 'yes'
        user-account-2:
          # connect to hosts in test domain using designated test key and execute custom command on connection
          '*.test.net':
            keyword: "Host"
            options:
              LocalCommand: '~/test/show_test_results'
              IdentityFile: '~/.ssh/test_rsa'
        user-account-3:
          # default keyword of 'Host'
          # also silence ssh client logging and use designated production key
          '*.prod.com':
            options:
              LogLevel: "QUIET"
              IdentityFile: '~/.ssh/prod_rsa'
  ```

#### Known Hosts

Like the SSH client configuration, SSH known hosts are configured based on both a global and per-user scope. Each type of config specification is defined under `ssh_config.known_hosts` and will be rendered at the appropriate locations (i.e. `/etc/ssh/ssh_known_hosts` # global and `~/.ssh/known_hosts` # per-user) accordingly.

_**Each specification contains several attributes detailing `markers` and `hostname` patterns associated with and accepted on behalf of the specified (host) `key`. [Reference](https://man.openbsd.org/sshd#SSH_KNOWN_HOSTS_FILE_FORMAT) for more details**_

`[ssh_config: known_hosts : {global | user-account} : {entry} :] marker: <@cert-authority | @revoke>` (**default**: *None*)
- indicates that the line contains either a certification authority (@cert-authority) key or the key contained on the line is revoked and must not ever be accepted (@revoked)

`[ssh_config: known_hosts : {global | user-account} : {entry} :] hostnames: <list of patterns>` (**default**: *None*)
- list of comma-separated patterns matched against hostnames to verify known identity

`[ssh_config: known_hosts : {global | user-account} : {entry} :] key: <host-pub-key>` (**default**:*None*)
- cryptographic public host key representing proof of authenticity for host being connected to

Cryptographic keys included can be expressed in several formats:
* _string - key definition containing: key-type, encoded key and additional comments_
* _file - local path on controller to file containing key definition_
* _hash - dict containing separate keys for key definition components ({type:...,encoding:...,comments:...})_

##### Example

 ```yaml
  ssh_config:
    known_hosts:
        # system-wide settings
        global:
          "Revoke ALL evil hosts":
            hostnames:
              - "*.evil.org"
            # key expressed as string
            key: "ssh-rsa @k3y..."
            # mark for revocation
            marker: "@revoked"
        user-account-1:
          # mark line contains a certification authority key
          'Certified Authorities':
            hostnames:
              # host name stored in hash form
              - "|1|JfKTdBh7rNbXkVAQCRp4OQoPfmI=|USECr3SWf1JUPsms5AqfD5QfxkM="
              - "certified.net,*.mydomain.org,*.mydomain.com"
            # host key read from file
            key: "/etc/ssh/cert_auth_host_rsa.pub"
            marker: "@cert-authority"
        user-account-2:
          'Organization network':
            hostnames:
              - "10.0.*.*"
              - "*.example.org"
              # negate access from known compromised subdomain
              - "!*compromised.example.org"
            key:
              type: "ssh-rsa"
              encoding: "th!s!s@HoSTk3y"
              comments: "Known host key"
  ```

#### Authorized Keys

SSH authorized keys are configured on a per-user basis only. Each key specification is defined under `ssh_config.authorized_keys` and rendered at the appropriate location under the specified user's local SSH directory (i.e. `~/.ssh/authorized_keys`).

_**Each entry contains several attributes detailing an`(authorized_)key` and `options` to associate with connection requests based on that key. [Reference](https://man.openbsd.org/sshd#AUTHORIZED_KEYS_FILE_FORMAT) for more details**_

`[ssh_config : authorized_keys : {user-account} : {entry}:] key: <pub-key>` (**default**: *None*)
- cryptographic public key representing proof of authenticity for client's connecting to the target user account

As with the *known_hosts* configuration above, authorized keys included can be expressed in several formats:
* _string - key definition containing: key-type, encoded key and additional comments_
* _file - local path on controller to file containing keydefinition_
* _hash - dict containing separate keys for key definition components ({type:...,encoding:...,comments:...})_

`[ssh_config : authorized_keys : {user-account} : {entry} :] options : <list of options>` (**default**: *None*)
- list of options to apply to connections

##### Example

 ```yaml
  ssh_config:
    authorized_keys:
        user-account-1:
          "Basic Connection w/ no custom options":
            key:
              type: "ssh-rsa"
              encoding: "th!s!s@k3y"
              comments: "these are the key comments"
          "Backup home directory":
            options:
              - "command='dump /home/user-account-1'"
              - "no-pty"
              - "no-port-forwarding"
            key: "/home/user-account-1/.ssh/home_dump.pub"
  ```
#### User Identities

Use the `user_identities` configuration object to manage cryptographic public and private key pairs owned by various users. This functionality allows for copying of both public and private keys into their respective locations for user-host/account access across operated machines (i.e. `~/.ssh/`). Each identity specification is defined under `ssh_config.user_identities` and expects keys and paths relative to the controller machine's filesystem.

_**Due to the sensitive and precise nature of handling user identities, keys are only copied from files as is to target machine. [Reference](https://www.ssh.com/ssh/identity-key) for further reading**_

`[ssh_config : user_identities : {user-account} :] src: <key-file-path>` (**default**: *None*)
- cryptographic key path located on local controller to be copied to target machine on behalf of designated *user-account*

`[ssh_config : user_identities : {user-account} :] dest: <key-file-name>` (**default**: *None*)
- name of destination key-file to be copied to target machine

##### Example

 ```yaml
  ssh_config:
    user_identities:
        user-account-1:
          src: "/home/user-account-1/id_rsa"
          dest: "my_rsa"
  ```

### Launch

Execution of both the `openssh` and `ssh-agent` daemons is accomplished utilizing the [systemd](https://www.freedesktop.org/wiki/Software/systemd/) service management tool, standard on most Linux platforms. Both can be customized to adhere to system administrative policies by using the following launch arguments:

`extra_run_args: <cli-options>` (**default**: None)
- list of `sshd` commandline arguments to pass to the executable at runtime for customizing launch. This variable enables the role to be customized according to the operator's specification; whether to activate a particular operational mode, force use of a specific type of IPv address family or pass additional runtime configuration values

A list of available command-line options can be found [here](https://www.freebsd.org/cgi/man.cgi?sshd(8)).

#### Example

```yaml
# Launch the SSH daemon only accepting IPv4 addresses and also writing log output to a location besides the system log
extra_run_args: "-4 -E /var/log/sshd.log"
```

`[auto_enable_agent : <account>] : run_args: <cli-options>` (**default**: *None*)
- list of `ssh-agent` commandline arguments to modify the default behavior of individual user's SSH authentication and key caching agent. Of note, a default value for the maximum lifetime of identities added to the agent may be specified. The lifetime may be expressed in seconds or in a time format

A list of available command-line options can be found [here](https://linux.die.net/man/1/ssh-agent).

#### Example

  ```yaml
  auto_enable_agent:
    # user
    example:
       # automatically install a user-scoped ssh-agent for the *example* user and specify
       # a maximum lifetime for cached identities of 86,400 seconds (or 1 day):
       run_args: "-t 86400"
  ```

### Uninstall

Remove customized user managed configs, returning the target host to its configured state prior to application of this role with the exception of managed global config settings (e.g. can be useful for recycling users and cleaning up stale settings).

_The following variable(s) can be customized to manage this uninstall process:_

`perform_uninstall: <true | false>` (**default**: `false`)
- whether to uninstall custom user configurations, based on defined role configuration at time of execution, on a target host (**see**: `handlers/main.yml` for details)

Dependencies
------------

None

Example Playbook
----------------

Basic setup with defaults:
```
- hosts: all
  roles:
  - role: 0x0I.openssh
```

Hardened production setup with heightened security configurations:
```
- hosts: prod
  roles:
  - role: 0x0I.openssh
    vars:
      ssh_config:
        service:
          # user authentication
          AllowGroups: "devops security"
          AuthenticationMethods: "publickey"
          PermitRootLogin: "no"
          PermitEmptyPasswords: "no"
          AddKeysToAgent: "confirm"
          # session privacy and data-integrity
          Ciphers: "chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr"
          MACs: "hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,umac-128@openssh.com"
          IgnoreRhosts: "yes"
          # session management
          ClientAliveInterval: "60"
          ClientAliveCountMax: "2"
          X11Forwarding: "no"
          Banner: "You are requesting access to a PRODUCTION environment. **Proceed with caution**"
        client:
          global:
            '*':
              options:
                ForwardAgent: "no"
                AddKeysToAgent: "confirm"
                HashKnownHosts: "yes"
                HostKeyAlgorithms: "ssh-ed25519-cert-v01@openssh.com,ssh-rsa-cert-v01@openssh.com,ssh-ed25519,ssh-rsa"
```

Only manage client/user configs and authorized keys:
```
- hosts: computer_lab
  roles:
  - role: 0x0I.openssh
    vars:
      managed_configs:
        - client
        - authorized_keys
      ssh_config:
        client:
          .
          .
          .
        authorized_keys:
          .
          .
          .
```

Agile-development environment settings:
```
- hosts: dev
  roles:
  - role: 0x0I.openssh
    vars:
      ssh_config:
        service:
          AllowGroups: "ssh-user"
          AllowAgentForwarding: "yes"
          AddKeysToAgent: "yes"
        client:
          global:
            '*.dev.net':
              options:
                ForwardAgent: "yes"
                RemoteCommand: "/home/devops/launch_team_dashboard --user %r"
            '*.test.net':
              options:
                ForwardAgent: "yes"
                RemoteCommand: "/home/devops/launch_testenv_dashboard --user %r"
```

License
-------

MIT

Author Information
------------------

This role was created in 2019 by O1.IO.
