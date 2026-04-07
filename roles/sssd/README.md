# sssd

Configure SSSD for directory integration.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
sssd_domain_name: ads.krz.-uni-heidelberg.de
sssd_ad_group_allowd_ssh_and_sudo: Linux-Admins
sssd_ad_group_allowd_ssh_and_sudo_extra: []
sssd_ou_to_join_servers: OU=Linux Server,DC=domain,DC=intra
sssd_bind_user: ''
sssd_bind_password: ''
```

## Example Playbook

```yaml
- name: Apply sssd
  hosts: all
  become: true
  roles:
    - role: lenmail.default_server.sssd
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/sssd/tests/test.yml`.
