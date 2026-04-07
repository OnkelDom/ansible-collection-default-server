# mounts

Manage filesystem and network mounts.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
mounts_defaults: []
```

## Example Playbook

```yaml
- name: Apply mounts
  hosts: all
  become: true
  roles:
    - role: lenmail.default_server.mounts
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/mounts/tests/test.yml`.
