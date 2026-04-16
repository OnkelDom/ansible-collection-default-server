# borgmatic

Install and configure borgmatic backup jobs and timers.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
borgmatic_manage_packages: true
borgmatic_package_state: present
borgmatic_install_method: uv
borgmatic_version: 2.0.11
borgmatic_config_dir: /etc/borgmatic
borgmatic_config_file: /etc/borgmatic/config.yaml
borgmatic_environment_file: /etc/borgmatic/borgmatic.env
borgmatic_manage_local_repositories: true
borgmatic_manage_timer: false
borgmatic_timer_enabled: true
borgmatic_timer_state: started
borgmatic_timer_on_calendar: '*-*-* 03:17:00'
borgmatic_timer_randomized_delay_sec: 30m
borgmatic_timer_persistent: true
borgmatic_verbosity: 1
borgmatic_actions: []
borgmatic_environment: {}
borgmatic_config:
  source_directories:
  - /etc
  repositories:
  - path: /var/backups/borgmatic
    label: local
    encryption: none
  keep_daily: 7
  keep_weekly: 4
  keep_monthly: 6
  checks:
  - name: repository
  - name: archives
    frequency: 2 weeks
```

## Example Playbook

```yaml
- name: Apply borgmatic
  hosts: all
  become: true
  roles:
    - role: onkeldom.default_server.borgmatic
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/borgmatic/tests/test.yml`.
