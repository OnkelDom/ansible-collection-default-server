# systemd_timesyncd

Configure systemd-timesyncd NTP settings.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
systemd_timesyncd: true
systemd_timesyncd_time_zone: Europe/Berlin
systemd_timesyncd_time_server: time.cloudflare.com
systemd_timesyncd_time_server_fallback: 0.de.pool.ntp.org 1.de.pool.ntp.org 2.de.pool.ntp.org 3.de.pool.ntp.org
```

## Example Playbook

```yaml
- name: Apply systemd_timesyncd
  hosts: all
  become: true
  roles:
    - role: lenmail.default_server.systemd_timesyncd
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/systemd_timesyncd/tests/test.yml`.
