# motd

Configure the login message of the day.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

This role does not define defaults in `defaults/main.yml`.

## Example Playbook

```yaml
- name: Apply motd
  hosts: all
  become: true
  roles:
    - role: inframonks.default_server.motd
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/motd/tests/test.yml`.
