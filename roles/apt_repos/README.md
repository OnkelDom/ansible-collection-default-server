# apt_repos

Manage APT repository definitions and signing keys on Debian-based systems.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
apt_repos_directory: /etc/apt/sources.list.d
apt_repos_keyring_directory: /etc/apt/keyrings
apt_repos_manage_keys: true
apt_repos_manage_cache: true
apt_repos_remove_original: false
apt_repos_list: []
```

## Example Playbook

```yaml
- name: Apply apt_repos
  hosts: all
  become: true
  roles:
    - role: lenmail.default_server.apt_repos
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/apt_repos/tests/test.yml`.
