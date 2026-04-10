# haproxy

Install and configure HAProxy load balancers and TLS assets.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
haproxy_package_name: haproxy
haproxy_service_name: haproxy
haproxy_manage_service: true
haproxy_service_enabled: true
haproxy_service_state: started
haproxy_server_user: haproxy
haproxy_server_group: haproxy
haproxy_server_fqdns: []
haproxy_server_tls_certs_dir: /etc/haproxy/certs
haproxy_server_tls_crt_list_path: /etc/haproxy/crt-list.txt
haproxy_manage_letsencrypt_certs: true
haproxy_manage_firewall: false
haproxy_firewall_zone: public
haproxy_manage_selinux: true
haproxy_firewall_ports:
- 80/tcp
- 443/tcp
haproxy_selinux_ports: '{{ haproxy_firewall_ports }}'
haproxy_frontends_list: []
haproxy_backends_list: []
haproxy_listens_list: []
haproxy_userlists_list: []
haproxy_global_config:
  log:
  - /dev/log local0
  - /dev/log local1 notice
  user: '{{ haproxy_server_user }}'
  group: '{{ haproxy_server_group }}'
  daemon: true
haproxy_defaults_config:
  log: global
  mode: http
  option:
  - httplog
  - dontlognull
  timeout:
    connect: 5s
    client: 50s
    server: 50s
```

## Example Playbook

```yaml
- name: Apply haproxy
  hosts: all
  become: true
  roles:
    - role: lenmail.default_server.haproxy
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/haproxy/tests/test.yml`.
