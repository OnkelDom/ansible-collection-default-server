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
  loki:
    write:
    - endpoint: '{{ alloy_loki_endpoint }}'
      tenant_id: '{{ alloy_normal_logs_tenant }}'
    - endpoint: '{{ alloy_loki_endpoint }}'
      tenant_id: '{{ alloy_audit_logs_tenant }}'
    source:
      file:
      - targets:
        - __path__: /var/log/syslog
          job: syslog
          log_type: system
          host: '{{ ansible_hostname }}'
        - __path__: /var/log/messages
          job: messages
          log_type: system
          host: '{{ ansible_hostname }}'
        - __path__: /var/log/daemon.log
          job: daemon
          log_type: system
          host: '{{ ansible_hostname }}'
        forward_to:
        - loki_0
      - targets:
        - __path__: /var/log/audit/audit.log
          job: audit
          log_type: security
          host: '{{ ansible_hostname }}'
        - __path__: /var/log/auth.log
          job: auth
          log_type: security
          host: '{{ ansible_hostname }}'
        - __path__: /var/log/secure
          job: secure
          log_type: security
          host: '{{ ansible_hostname }}'
        forward_to:
        - loki_1
alloy_manage_firewall: false
alloy_firewall_enabled: false
alloy_firewall_zone: public
alloy_manage_selinux: true
alloy_firewall_ports: []
alloy_selinux_ports: '{{ alloy_firewall_ports }}'
alloy_service_override: {}
```

Example inventory configuration for Linux log shipping to Loki:

```yaml
alloy_loki_endpoint: https://syslog01.example.invalid:8443/loki/api/v1/push
alloy_normal_logs_tenant: prime
alloy_audit_logs_tenant: prime
alloy_config:
  logging:
    level: "{{ alloy_log_level }}"
    format: logfmt
  loki:
    write:
      - endpoint: "{{ alloy_loki_endpoint }}"
        tenant_id: "{{ alloy_normal_logs_tenant }}"
      - endpoint: "{{ alloy_loki_endpoint }}"
        tenant_id: "{{ alloy_audit_logs_tenant }}"
    source:
      file:
        - targets:
            - __path__: /var/log/syslog
              job: syslog
              log_type: system
              host: "{{ ansible_hostname }}"
            - __path__: /var/log/messages
              job: messages
              log_type: system
              host: "{{ ansible_hostname }}"
            - __path__: /var/log/daemon.log
              job: daemon
              log_type: system
              host: "{{ ansible_hostname }}"
          forward_to:
            - loki_0
        - targets:
            - __path__: /var/log/audit/audit.log
              job: audit
              log_type: security
              host: "{{ ansible_hostname }}"
            - __path__: /var/log/auth.log
              job: auth
              log_type: security
              host: "{{ ansible_hostname }}"
            - __path__: /var/log/secure
              job: secure
              log_type: security
              host: "{{ ansible_hostname }}"
          forward_to:
            - loki_1
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
