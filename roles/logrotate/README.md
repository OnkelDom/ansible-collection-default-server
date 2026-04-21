# logrotate

Manage custom logrotate rules for application and service logs.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
logrotate_manage_package: true
logrotate_package_state: present
logrotate_config_dir: /etc/logrotate.d
logrotate_file_prefix: onkeldom-
logrotate_prune_managed_files: false
logrotate_rule_defaults:
  state: present
  frequency: weekly
  rotate: 8
  missingok: true
  notifempty: true
  compress: true
  delaycompress: false
  copytruncate: false
  sharedscripts: false
  dateext: false
  dateyesterday: false
  create: false
  create_mode: '0640'
  create_owner: root
  create_group: root
  su_user:
  su_group:
  olddir:
  extension:
  dateformat:
  size:
  minsize:
  maxsize:
  minage:
  maxage:
  start:
  mail:
  mailfirst: false
  maillast: false
  firstaction: ''
  prerotate: ''
  postrotate: ''
  lastaction: ''
  extra_directives: []
logrotate_rules: []
```

## Example Playbook

```yaml
- name: Configure custom log rotation policies
  hosts: linux_hosts
  become: true
  roles:
    - role: onkeldom.default_server.logrotate
      vars:
        logrotate_rules:
          - name: myapp
            paths:
              - /var/log/myapp/*.log
            frequency: daily
            rotate: 14
            compress: true
            delaycompress: true
            create: true
            create_mode: "0640"
            create_owner: myapp
            create_group: myapp
            sharedscripts: true
            postrotate: |
              systemctl reload myapp.service >/dev/null 2>&1 || true
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/logrotate/tests/test.yml`.
