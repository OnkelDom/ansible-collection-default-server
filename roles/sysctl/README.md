# sysctl

Manage sysctl kernel parameters.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
sysctl_defaults:
  net.ipv4.ip_forward: 1
  net.ipv4.conf.all.rp_filter: 1
  vm.swappiness: 10
  vm.vfs_cache_pressure: 50
sysctl_group_vars: {}
sysctl_host_vars: {}
sysctl_playbook: {}
```

## Example Playbook

```yaml
- name: Apply sysctl
  hosts: all
  become: true
  roles:
    - role: lenmail.default_server.sysctl
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/sysctl/tests/test.yml`.
