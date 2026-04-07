# postfix_mta

Configure Postfix as a relay or local MTA.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
postfix_mta_hostname: '{{ ansible_hostname }}'
postfix_mta_domain: '{{ ansible_domain }}'
postfix_mta_relayhost: ''
postfix_mta_root_mail: root
postfix_mta_aliases:
  support: root
```

## Example Playbook

```yaml
- name: Apply postfix_mta
  hosts: all
  become: true
  roles:
    - role: inframonks.default_server.postfix_mta
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/postfix_mta/tests/test.yml`.
