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
firewalld_group_vars_services: []
firewalld_group_vars_zones: []
firewalld_group_vars_custom_zones: []
firewalld_group_vars_rules: []
firewalld_host_vars_services: []
firewalld_host_vars_zones: []
firewalld_host_vars_custom_zones: []
firewalld_host_vars_rules: []
firewalld_playbook_services: []
firewalld_playbook_zones: []
firewalld_playbook_custom_zones: []
firewalld_playbook_rules: []
```

## Example Playbook

```yaml
- name: Apply firewalld
  hosts: all
  become: true
  roles:
    - role: lenmail.default_server.firewalld
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/firewalld/tests/test.yml`.
