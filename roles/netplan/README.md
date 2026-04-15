# netplan

Manage netplan configuration on Debian and Ubuntu.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
netplan_file: 01-netcfg.yaml
netplan_path: /etc/netplan
netplan_config: {}
netplan_enabled: true
netplan_manage_service: true
netplan_packages:
- netplan.io
netplan_renderer: networkd
netplan_version: 2
netplan_wipe: true
```

## Example Playbook

```yaml
- name: Apply netplan
  hosts: all
  become: true
  roles:
    - role: onkeldom.default_server.netplan
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/netplan/tests/test.yml`.
