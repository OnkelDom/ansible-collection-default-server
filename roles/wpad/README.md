# wpad

Manage a proxy auto-configuration file and publish it through Apache or NGINX.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
proxy_env: {}
wpad_state: present
wpad_webserver: nginx
wpad_manage_webserver_config: true
wpad_manage_service: true
wpad_document_root: /var/www/wpad
wpad_pac_filename: proxy.pac
wpad_enable_wpad_dat: true
wpad_server_names:
- wpad
- proxy
wpad_listen_port: 80
wpad_listen_ipv6: true
wpad_cache_control_header: public, max-age=300
wpad_return_string: ''
wpad_proxy_targets: []
wpad_direct_fallback: true
wpad_bypass_plain_hostnames: true
wpad_bypass_localhost: true
wpad_bypass_exact_hosts:
- localhost
- 127.0.0.1
- ::1
wpad_bypass_domain_suffixes:
- .local
- .localdomain
wpad_bypass_host_globs: []
wpad_bypass_networks: []
wpad_custom_rules: []
wpad_extra_pac_logic: ''
```

## Example Playbook

```yaml
- name: Apply wpad
  hosts: all
  become: true
  roles:
    - role: lenmail.default_server.wpad
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/wpad/tests/test.yml`.
