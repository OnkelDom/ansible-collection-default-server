# borgbackup

Install and configure BorgBackup jobs and defaults.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
borgbackup_repository: /var/backups/borg
borgbackup_source_paths:
- /etc
borgbackup_archive_name: '{{ ansible_date_time.iso8601_basic_short }}'
borgbackup_encryption_mode: repokey
borgbackup_encryption_passphrase: ''
borgbackup_keep_daily: 7
borgbackup_keep_weekly: 4
borgbackup_keep_monthly: 6
borgbackup_script_path: /usr/local/bin/borgbackup.sh
borgbackup_cron_minute: '0'
borgbackup_cron_hour: '2'
```

## Example Playbook

```yaml
- name: Apply borgbackup
  hosts: all
  become: true
  roles:
    - role: inframonks.default_server.borgbackup
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/borgbackup/tests/test.yml`.
