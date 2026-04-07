# sftp_server

Manage chrooted SFTP-only accounts and SSH match configuration.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
sftp_server_group: sftp
sftp_server_base_path: /srv/sftp
sftp_server_home_base: /var/lib/sftp-home
sftp_server_manage_sshd: true
sftp_server_allow_password_auth: false
sftp_server_allow_public_key_auth: true
sftp_server_default_shell: /usr/sbin/nologin
sftp_server_default_directories:
- upload
- download
sftp_server_directory_mode: '0750'
sftp_server_remove_home_on_absent: false
sftp_server_remove_chroot_on_absent: false
sftp_server_internal_sftp_options: []
sftp_server_users: []
```

## Example Playbook

```yaml
- name: Apply sftp_server
  hosts: all
  become: true
  roles:
    - role: lenmail.default_server.sftp_server
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/sftp_server/tests/test.yml`.
