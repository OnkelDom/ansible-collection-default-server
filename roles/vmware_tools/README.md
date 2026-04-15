# vmware_tools

Install open-vm-tools on supported Linux systems.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
vmware_tools_package_state: present
vmware_tools_manage_service: true
vmware_tools_service_enabled: true
vmware_tools_service_state: started
```

## Example Playbook

```yaml
- name: Apply vmware_tools
  hosts: all
  become: true
  roles:
    - role: onkeldom.default_server.vmware_tools
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/vmware_tools/tests/test.yml`.
