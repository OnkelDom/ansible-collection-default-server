# multipath

Configure device-mapper multipath on supported Linux systems.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
multipath_manage_service: true
multipath_service_enabled: true
multipath_service_state: started
multipath_friendly_names: yes
multipath_blackbist: ^(ram|raw|loop|fd|md|dm-|sr|scd|st|sd[a-z])[0-9]*
multipath_pathes: {}
```

## Example Playbook

```yaml
- name: Apply multipath
  hosts: all
  become: true
  roles:
    - role: onkeldom.default_server.multipath
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/multipath/tests/test.yml`.
