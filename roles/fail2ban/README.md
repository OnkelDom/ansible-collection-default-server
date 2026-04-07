# fail2ban

Install and configure Fail2ban jails and actions.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
fail2ban_mail_recipient: root@localhost
fail2ban_loglevel: INFO
fail2ban_logtarget: /var/log/fail2ban.log
fail2ban_syslog_target: /var/log/fail2ban.log
fail2ban_syslog_facility: 1
fail2ban_socket: /var/run/fail2ban/fail2ban.sock
fail2ban_pidfile: /var/run/fail2ban/fail2ban.pid
fail2ban_sendername: "{{ ansible_hostname + '.' + ansible_domain if ansible_domain is defined and ansible_domain != '' else ansible_hostname }}"
fail2ban_ignoreips:
- 127.0.0.1/8
- ::1
- 10.0.0.0/8
- 100.64.0.0/10
- 169.254.0.0/16
- 172.16.0.0/12
- 192.168.0.0/16
- fc00::/7
- fe80::/10
fail2ban_bantime: 600
fail2ban_maxretry: 3
fail2ban_findtime: 600
fail2ban_backend: systemd
fail2ban_destemail: '{{ fail2ban_mail_recipient }}'
fail2ban_banaction: nftables-multiport
fail2ban_jails:
- name: sshd
  enabled: true
  jail_options:
    backend: systemd
```

## Example Playbook

```yaml
- name: Apply fail2ban
  hosts: all
  become: true
  roles:
    - role: inframonks.default_server.fail2ban
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/fail2ban/tests/test.yml`.
