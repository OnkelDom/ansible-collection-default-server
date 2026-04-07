# interfaces

Manage /etc/network/interfaces based network configuration.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
interfaces_config:
- name: lo
  bootproto: loopback
- name: '{{ ansible_default_ipv4.interface }}'
  bootproto: dhcp
  bootproto6: dhcp
  macaddr: '{{ ansible_default_ipv4.macaddress }}'
```

## Example Playbook

```yaml
- name: Apply interfaces
  hosts: all
  become: true
  roles:
    - role: lenmail.default_server.interfaces
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/interfaces/tests/test.yml`.
