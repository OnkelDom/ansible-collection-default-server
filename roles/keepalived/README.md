# keepalived

Install and configure Keepalived VRRP instances and helper scripts.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
keepalived_packages:
- keepalived
- iproute
keepalived_manage_service: true
keepalived_service_enabled: false
keepalived_service_state: stopped
keepalived_config_group_vars: {}
keepalived_config_host_vars: {}
keepalived_config_playbook: {}
keepalived_config_defaults:
  global_defs:
    router_id: '{{ inventory_hostname }}'
    script_user: root
    enable_script_security: true
  vrrp_scripts: []
  vrrp_instances: []
keepalived_logrotate_enabled: true
keepalived_logrotate_path: /etc/logrotate.d/keepalived-custom-logs
keepalived_logrotate_config:
  logfile: /var/log/keepalived-snat.log
  frequency: weekly
  rotate: 8
  compress: true
  delaycompress: true
  create_mode: '0640'
  create_owner: root
  create_group: adm
```

## Example Playbook

```yaml
- name: Apply keepalived
  hosts: all
  become: true
  roles:
    - role: lenmail.default_server.keepalived
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/keepalived/tests/test.yml`.
