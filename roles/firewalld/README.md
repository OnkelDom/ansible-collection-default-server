# firewalld

Manage firewalld services, zones, and rules on EL systems.

## Supported platforms

- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
firewalld_defaults_rules:
- service: ssh
  state: enabled
  permanent: true
- service: cockpit
  state: disabled
  permanent: true
- service: dhcpv6-client
  state: disabled
  permanent: true
firewalld_defaults_custom_zones: []
firewalld_defaults_zones: []
firewalld_defaults_services: []
```

## Example Playbook

```yaml
- name: Apply firewalld
  hosts: all
  become: true
  roles:
    - role: inframonks.default_server.firewalld
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/firewalld/tests/test.yml`.
