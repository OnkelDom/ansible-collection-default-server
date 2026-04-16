# alloy

Install and configure Grafana Alloy as a client-side telemetry agent.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
alloy_manage_service: true
alloy_service_enabled: true
alloy_service_state: started
alloy_config_file: /etc/alloy/config.alloy
alloy_user: alloy
alloy_group: alloy
alloy_log_level: info
alloy_loki_endpoint: ''
alloy_normal_logs_tenant: logs
alloy_audit_logs_tenant: audit
alloy_config:
  logging:
    level: '{{ alloy_log_level }}'
    format: logfmt
alloy_manage_firewall: false
alloy_firewall_enabled: false
alloy_firewall_zone: public
alloy_manage_selinux: true
alloy_firewall_ports: []
alloy_selinux_ports: '{{ alloy_firewall_ports }}'
alloy_service_override: {}
```

## Example Playbook

```yaml
- name: Apply alloy
  hosts: all
  become: true
  roles:
    - role: onkeldom.default_server.alloy
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/alloy/tests/test.yml`.
