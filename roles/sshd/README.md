# sshd

Configure OpenSSH client and server settings.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
sshd_manage_service: true
sshd_service_enabled: true
sshd_service_state: started
sshd_manage_firewall: false
sshd_firewall_zone: public
sshd_manage_selinux: true
sshd_bind_ips: false
sshd_client_defaults:
  ForwardX11Trusted: true
  GSSAPIAuthentication: true
  SendEnv:
  - LANG LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES
  - LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT
  - LC_IDENTIFICATION LC_ALL LANGUAGE
  - XMODIFIERS
sshd_client_group_vars: {}
sshd_client_host_vars: {}
sshd_client_playbook: {}
sshd_server_defaults:
  AcceptEnv:
  - LANG LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES
  - LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT
  - LC_IDENTIFICATION LC_ALL LANGUAGE
  - XMODIFIERS
  AddressFamily: any
  ChallengeResponseAuthentication: false
  GSSAPIAuthentication: true
  GSSAPICleanupCredentials: false
  HostKey:
  - /etc/ssh/ssh_host_rsa_key
  PasswordAuthentication: no
  PermitRootLogin: no
  PermitEmptyPasswords: no
  Port: 22
  Protocol: 2
  LoginGraceTime: 30
  StrictModes: yes
  MaxStartups: 200
  Subsystem: sftp internal-sftp
  SyslogFacility: AUTHPRIV
  UsePAM: true
  X11Forwarding: true
  PrintMotd: yes
  PrintLastLog: yes
  Ciphers: aes128-ctr,aes192-ctr,aes256-ctr,chacha20-poly1305@openssh.com
  MACs: hmac-sha2-256,hmac-sha2-512
  KexAlgorithms: curve25519-sha256,diffie-hellman-group-exchange-sha256
  PermitUserEnvironment: no
  MaxSessions: 10
  TCPKeepAlive: yes
  ClientAliveInterval: 300
  ClientAliveCountMax: 2
sshd_server_group_vars: {}
sshd_server_host_vars: {}
sshd_server_playbook: {}
```

## Example Playbook

```yaml
- name: Apply sshd
  hosts: all
  become: true
  roles:
    - role: onkeldom.default_server.sshd
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/sshd/tests/test.yml`.
