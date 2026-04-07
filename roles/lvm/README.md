# lvm

Create and manage LVM volume groups and logical volumes.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
lvm_config_defaults: []
```

## Example Playbook

```yaml
- name: Apply lvm
  hosts: all
  become: true
  roles:
    - role: lenmail.default_server.lvm
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/lvm/tests/test.yml`.
