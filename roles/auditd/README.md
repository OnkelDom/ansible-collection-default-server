# auditd

Manage additional auditd rules.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
auditd_extra_rules: []
```

## Example Playbook

```yaml
- name: Apply auditd
  hosts: all
  become: true
  roles:
    - role: inframonks.default_server.auditd
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/auditd/tests/test.yml`.
