# systemd_resolved

Configure systemd-resolved DNS settings.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
systemd_resolved_dns_server: 127.0.0.1
systemd_resolved_dns_stublistener: no
```

## Example Playbook

```yaml
- name: Apply systemd_resolved
  hosts: all
  become: true
  roles:
    - role: onkeldom.default_server.systemd_resolved
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/systemd_resolved/tests/test.yml`.
