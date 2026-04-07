# users

Manage local users, SSH keys, and shell dotfiles.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
users_defaults: []
users_group_vars: []
users_host_vars: []
users_playbook: []
users_manage_root_dotfiles: true
users_copy_msmtp_config: true
```

## Example Playbook

```yaml
- name: Apply users
  hosts: all
  become: true
  roles:
    - role: lenmail.default_server.users
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/users/tests/test.yml`.
