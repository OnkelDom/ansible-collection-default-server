# traefik

Install and configure Traefik reverse proxies and routing rules.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
proxy_env: {}
traefik_version: 2.10.5
traefik_binary_install_dir: /usr/local/bin
traefik_binary_path: '{{ traefik_binary_install_dir }}/traefik'
traefik_limit_nofile: 16384
traefik_service_name: traefik
traefik_user: traefik
traefik_group: traefik
traefik_external_domain: ''
traefik_acme_email: ''
traefik_http_proxy: ''
traefik_https_proxy: ''
traefik_rules_files: []
traefik_custom_cert_files: []
traefik_config:
  global:
    checkNewVersion: true
    sendAnonymousUsage: false
  api:
    insecure: false
    dashboard: true
  log:
    level: WARN
  entryPoints:
    http:
      address: :80
    https:
      address: :443
  providers:
    file:
      directory: /etc/traefik/rules
      watch: true
traefik_rules_config: {}
```

## Example Playbook

```yaml
- name: Apply traefik
  hosts: all
  become: true
  roles:
    - role: lenmail.default_server.traefik
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/traefik/tests/test.yml`.
