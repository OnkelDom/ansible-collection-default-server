# nmcli

Manage NetworkManager connections with community.general.nmcli.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
nmcli_default_iface: "{{ ansible_default_ipv4.interface | default('enp6s18') }}"
nmcli_default_gateway: '{{ ansible_default_ipv4.gateway | default(omit) }}'
nmcli_default_address: '{{ ansible_default_ipv4.address | default(omit) }}'
nmcli_default_netmask: '{{ ansible_default_ipv4.netmask | default(omit) }}'
nmcli_default_cidr: '{{ ansible_default_ipv4.network | default(omit) }}'
nmcli_interfaces:
- iface: '{{ nmcli_default_iface }}'
  state: up
  type: ethernet
  method4: auto
```

## Example Playbook

```yaml
- name: Apply nmcli
  hosts: all
  become: true
  roles:
    - role: inframonks.default_server.nmcli
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/nmcli/tests/test.yml`.
