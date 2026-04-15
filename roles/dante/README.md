# dante

Install and configure the Dante SOCKS proxy service.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
proxy_env: {}
dante_manage_service: true
dante_service_enabled: true
dante_service_state: started
dante_manage_firewall: false
dante_firewall_zone: public
dante_manage_selinux: true
dante_listen_address: 0.0.0.0
dante_listen_port: 1080
dante_listen_address_ipv6: '::'
dante_enable_ipv6: true
dante_selinux_ports:
- '{{ dante_listen_port }}/tcp'
dante_external_interface: '{{ ansible_default_ipv4.interface }}'
dante_user: sockd
dante_group: sockd
dante_log_directory: /var/log/sockd
dante_pid_directory: /run/sockd
dante_client_method: none
dante_socks_method: none
dante_client_rules: []
dante_socks_rules: []
```

## Example Playbook

```yaml
- name: Apply dante
  hosts: all
  become: true
  roles:
    - role: onkeldom.default_server.dante
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/dante/tests/test.yml`.
