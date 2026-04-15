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
- name: Configure custom EL repositories
  hosts: el_hosts
  become: true
  roles:
    - role: onkeldom.default_server.dnf_repos
      vars:
        dnf_repos_list:
          - name: epel
            description: Extra Packages for Enterprise Linux 9
            metalink: https://mirrors.fedoraproject.org/metalink?repo=epel-9&arch=$basearch
            gpgcheck: true
            gpgkey_url: https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-9
          - name: internal-base
            description: Internal Base Repository
            baseurl: https://repo.example.com/el9/baseos/$basearch
            enabled: true
            gpgcheck: true
            key_path: /etc/pki/rpm-gpg/RPM-GPG-KEY-internal-base
            gpgkey_url: https://repo.example.com/keys/RPM-GPG-KEY-internal-base
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/dnf_repos/tests/test.yml`.
