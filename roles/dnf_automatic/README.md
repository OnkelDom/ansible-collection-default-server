# dnf_automatic

Configure automatic package updates on EL systems.

## Supported platforms

- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
dnf_automatic_manage_service: true
dnf_automatic_service_enabled: true
dnf_automatic_service_state: started
dnf_automatic_apply_updates: yes
dnf_automatic_emit_via: email
dnf_automatic_email_from: '{{ smtp_user }}'
dnf_automatic_email_to: '{{ smtp_user }}'
dnf_automatic_email_host: "{{ smtp_host.split(':')[0] }}"
dnf_automatic_email_tls: yes
dnf_automatic_email_port: "{{ smtp_host.split(':')[1] }}"
dnf_automatic_email_auth: login
dnf_automatic_email_user:
dnf_automatic_email_password:
dnf_automatic_download_updates: yes
dnf_automatic_download_updates_command: /usr/bin/dnf-automatic-install
dnf_automatic_random_sleep: '1800'
dnf_automatic_system_package_cache: yes
dnf_automatic_upgrade_type: default
dnf_automatic_reboot: when-needed
```

## Example Playbook

```yaml
- name: Apply dnf_automatic
  hosts: all
  become: true
  roles:
    - role: onkeldom.default_server.dnf_automatic
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/dnf_automatic/tests/test.yml`.
