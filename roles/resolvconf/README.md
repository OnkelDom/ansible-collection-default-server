# resolvconf

Manage resolver nameservers and search domains.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
resolvconf_nameservers:
- 1.0.0.1
- 1.1.1.1
resolvconf_search_domains: []
```

## Example Playbook

```yaml
- name: Apply resolvconf
  hosts: all
  become: true
  roles:
    - role: inframonks.default_server.resolvconf
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/resolvconf/tests/test.yml`.
