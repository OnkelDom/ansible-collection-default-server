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
- name: Configure third-party APT repositories
  hosts: debian_hosts
  become: true
  roles:
    - role: onkeldom.default_server.apt_repos
      vars:
        apt_repos_list:
          - name: docker
            uris:
              - https://download.docker.com/linux/{{ ansible_distribution | lower }}
            suites:
              - "{{ ansible_distribution_release }}"
            components:
              - stable
            architectures:
              - "{{ ansible_architecture }}"
            key_url: https://download.docker.com/linux/{{ ansible_distribution | lower }}/gpg
          - name: hashicorp
            uris:
              - https://apt.releases.hashicorp.com
            suites:
              - "{{ ansible_distribution_release }}"
            components:
              - main
            key_url: https://apt.releases.hashicorp.com/gpg
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/apt_repos/tests/test.yml`.
