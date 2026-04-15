# unbound

Install and configure the Unbound DNS resolver and local zones.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
unbound_use_blocklist: false
unbound_blocklist_url: https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
unbound_manage_service: true
unbound_service_enabled: true
unbound_service_state: started
unbound_manage_firewall: false
unbound_firewall_zone: public
unbound_manage_selinux: true
unbound_zones_dir: '{{ unbound_config_dir }}/zones.d'
unbound_local_zones: []
unbound_auth_zones: []
unbound_config:
  server:
    verbosity: 1
    num-threads: '{{ ansible_processor_vcpus | default(ansible_processor_count | default(1)) }}'
    root-hints: '{{ unbound_root_hints_path }}'
    tls-cert-bundle: '{{ unbound_tls_cert_bundle }}'
    log-queries: true
    port: 53
    prefetch: true
    hide-identity: true
    hide-version: true
    do-daemonize: true
    interface:
    - 0.0.0.0
    - ::0
    access-control:
    - 127.0.0.0/8 allow
    - ::1/128 allow
  remote-control:
    control-enable: false
```

## Example Playbook

```yaml
- name: Apply unbound
  hosts: all
  become: true
  roles:
    - role: onkeldom.default_server.unbound
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/unbound/tests/test.yml`.
