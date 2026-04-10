# squid

Install and configure the Squid HTTP proxy service.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
proxy_env: {}
squid_manage_service: true
squid_service_enabled: true
squid_service_state: started
squid_manage_firewall: false
squid_firewall_zone: public
squid_manage_selinux: true
squid_port: 3128
squid_config_dir: '{{ squid_os_config_dir }}'
squid_conf_d_dir: '{{ squid_os_conf_d_dir }}'
squid_user: squid
squid_group: squid
squid_visible_hostname: '{{ ansible_fqdn | default(ansible_hostname) }}'
squid_cache_mgr: hostmaster@{{ ansible_domain | default('localdomain') }}
squid_ssl_ports:
- 443
squid_safe_ports:
- 80
- 443
squid_acl_files: []
squid_acl_definitions: []
squid_http_access_rules: []
squid_extra_config: []
```

## Example Playbook

```yaml
- name: Apply squid
  hosts: all
  become: true
  roles:
    - role: lenmail.default_server.squid
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/squid/tests/test.yml`.
