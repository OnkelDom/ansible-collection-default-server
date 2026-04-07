# msmtp

Configure msmtp relay accounts and aliases.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
msmtp_auth: 'on'
msmtp_tls: 'on'
msmtp_tls_starttls: 'on'
msmtp_set_from_header: 'on'
msmtp_syslog: 'on'
msmtp_default_account: default
msmtp_accounts:
- name: default
  host: smtp.example.com
  port: '587'
  from: user@example.com
  user: user@example.com
  password: password
msmtp_aliases: {}
```

## Example Playbook

```yaml
- name: Apply msmtp
  hosts: all
  become: true
  roles:
    - role: inframonks.default_server.msmtp
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/msmtp/tests/test.yml`.
