# hosts

Manage hostname-related entries in /etc/hosts.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
hosts_hostname: '{{ ansible_hostname }}'
hosts_domain: "{{ ansible_domain | default('') }}"
hosts_ipv4: "{{ ansible_default_ipv4.address | default('') }}"
hosts_ipv6: "{{ ansible_default_ipv6.address | default('') }}"
hosts_alias: []
hosts_entrys: []
```

## Example Playbook

```yaml
- name: Apply hosts
  hosts: all
  become: true
  roles:
    - role: onkeldom.default_server.hosts
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/hosts/tests/test.yml`.
