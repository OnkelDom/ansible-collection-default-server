# ifcfg

Manage legacy ifcfg-based network configuration on EL systems.

## Supported platforms

- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
ifcfg_interfaces:
- device: '{{ ansible_default_ipv4.interface }}'
  bootproto: dhcp
  onboot: yes
  macaddr: '{{ ansible_default_ipv4.macaddress }}'
```

## Example Playbook

```yaml
- name: Apply ifcfg
  hosts: all
  become: true
  roles:
    - role: lenmail.default_server.ifcfg
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/ifcfg/tests/test.yml`.
