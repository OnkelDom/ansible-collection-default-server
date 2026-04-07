# telegraf

Install and configure Telegraf with plugin definitions.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
telegraf_repo_url: "{{ 'https://repos.influxdata.com/debian stable main' if ansible_os_family == 'Debian' else 'https://repos.influxdata.com/rhel/9/x86_64/stable/' }}"
telegraf_gpg_key_url: "{{ 'https://repos.influxdata.com/influxdb.key' }}"
telegraf_config_path: /etc/telegraf/telegraf.conf
telegraf_plugins_path: /etc/telegraf/telegraf.d
telegraf_service_name: telegraf
telegraf_plugins: []
telegraf_config:
  agent:
    interval: 10s
    round_interval: true
    metric_batch_size: 1000
    metric_buffer_limit: 10000
    collection_jitter: 0s
    flush_interval: 10s
    flush_jitter: 0s
    precision: ''
    hostname: '{{ ansible_hostname }}'
    omit_hostname: false
  outputs:
  - type: loki
    config:
      url: http://loki.local:3100/loki/api/v1/push
      labels:
        job: telegraf
        host: '{{ ansible_hostname }}'
  - type: prometheus_client
    config:
      listen: :9273
      metric_version: 2
  inputs:
  - type: cpu
    config:
      percpu: true
      totalcpu: true
      collect_cpu_time: false
      report_active: false
  - type: mem
    config: {}
  - type: disk
    config:
      ignore_fs:
      - tmpfs
      - devtmpfs
  - type: net
    config: {}
  - type: system
    config: {}
  - type: smart
    config:
      attributes: true
      devices:
      - /dev/sda
      - /dev/vda
      - /dev/sdb
      - /dev/vdb
  - type: procstat
    config:
      pid_file: /var/run/sshd.pid
  - type: service
    config:
      services:
      - sshd
      - cron
      - systemd-journald
  - type: journald
    config:
      files:
      - /var/log/journal
      from_beginning: false
      max_entries: 5000
  - type: logparser
    config:
      files:
      - /var/log/syslog
      - /var/log/messages
      from_beginning: true
      name_override: journald
```

## Example Playbook

```yaml
- name: Apply telegraf
  hosts: all
  become: true
  roles:
    - role: lenmail.default_server.telegraf
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/telegraf/tests/test.yml`.
