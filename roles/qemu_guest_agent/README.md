# qemu_guest_agent

Install the QEMU guest agent package.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
qemu_guest_agent_manage_service: true
qemu_guest_agent_service_enabled: true
qemu_guest_agent_service_state: started
```

## Example Playbook

```yaml
- name: Apply qemu_guest_agent
  hosts: all
  become: true
  roles:
    - role: lenmail.default_server.qemu_guest_agent
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/qemu_guest_agent/tests/test.yml`.
