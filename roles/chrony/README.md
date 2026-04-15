# chrony

Install and configure Chrony for time synchronization.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
chrony_set_time_zone: true
chrony_timezone: Europe/Berlin
chrony_manage_ntp: true
chrony_manage_service: true
chrony_service_enabled: true
chrony_service_state: started
chrony_servers:
- 0.de.pool.ntp.org
- 1.de.pool.ntp.org
- 2.de.pool.ntp.org
- 3.de.pool.ntp.org
chrony_allowed:
- 127.0.0.1
- ::1
```

## Example Playbook

```yaml
- name: Apply chrony
  hosts: all
  become: true
  roles:
    - role: onkeldom.default_server.chrony
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/chrony/tests/test.yml`.
