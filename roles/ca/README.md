# ca

Deploy custom certificate authorities.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
ca_source_path: ca/*
```

## Example Playbook

```yaml
- name: Apply ca
  hosts: all
  become: true
  roles:
    - role: onkeldom.default_server.ca
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/ca/tests/test.yml`.
