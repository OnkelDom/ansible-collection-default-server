# ufw

Manage UFW rules and defaults on Debian and Ubuntu.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
ufw_rules_defaults:
- name: OpenSSH
  rule: allow
ufw_manage_config: true
ufw_config:
  IPV6: 'yes'
  DEFAULT_INPUT_POLICY: DROP
  DEFAULT_OUTPUT_POLICY: ACCEPT
  DEFAULT_FORWARD_POLICY: DROP
  DEFAULT_APPLICATION_POLICY: SKIP
  MANAGE_BUILTINS: 'no'
  IPT_SYSCTL: /etc/ufw/sysctl.conf
  IPT_MODULES: ''
```

## Example Playbook

```yaml
- name: Apply ufw
  hosts: all
  become: true
  roles:
    - role: inframonks.default_server.ufw
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/ufw/tests/test.yml`.
