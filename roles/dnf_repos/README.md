# dnf_repos

Manage YUM and DNF repository definitions and signing keys on EL systems.

## Supported platforms

- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
dnf_repos_directory: /etc/yum.repos.d
dnf_repos_key_directory: /etc/pki/rpm-gpg
dnf_repos_manage_keys: true
dnf_repos_remove_original: false
dnf_repos_list: []
```

## Example Playbook

```yaml
- name: Apply dnf_repos
  hosts: all
  become: true
  roles:
    - role: lenmail.default_server.dnf_repos
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/dnf_repos/tests/test.yml`.
