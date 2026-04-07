# node_exporter

Install and configure Prometheus node_exporter.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
proxy_env: {}
node_exporter_version: 1.8.2
node_exporter_web_listen_address: 0.0.0.0
node_exporter_binary_install_dir: /usr/local/bin
node_exporter_binary_path: '{{ node_exporter_binary_install_dir }}/node_exporter'
node_exporter_web_listen_port: 9100
node_exporter_system_user: "{{ prometheus_user | default('node_exporter') }}"
node_exporter_system_group: "{{ prometheus_group | default('node_exporter') }}"
node_exporter_user_additional_groups: adm
node_exporter_create_consul_agent_service: false
node_exporter_textfile_dir: /var/lib/node_exporter
node_exporter_config_dir: /etc/node_exporter
node_exporter_log_level: warn
node_exporter_log_format: json
node_exporter_disable_go_metrics: true
node_exporter_textfile_collectors: []
node_exporter_tls_server_config: {}
node_exporter_http_server_config: {}
node_exporter_basic_auth_users: {}
node_exporter_enabled_collectors:
- filesystem:
    mount-points-exclude: ^/(boot|boot/efi|dev.+|proc|run|run.+|sys.+|var/lib/docker.+|var/lib/containers/storage.+)($|/)$
- textfile:
    directory: '{{ node_exporter_textfile_dir }}'
node_exporter_disabled_collectors:
- bonding
- zfs
- btrfs
- infiniband
- edac
- nfs
- nfsd
- xfs
- vmstat
- entropy
- rapl
node_exporter_webconfig: []
```

## Example Playbook

```yaml
- name: Apply node_exporter
  hosts: all
  become: true
  roles:
    - role: lenmail.default_server.node_exporter
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/node_exporter/tests/test.yml`.
