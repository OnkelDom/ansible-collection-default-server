# unattended_updates

Configure unattended upgrades on Debian and Ubuntu.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
unattended_updates_updates_cache_valid_time: 3600
unattended_updates_origins_patterns:
- origin=Ubuntu,archive=${distro_codename}-security
- o=Ubuntu,a=${distro_codename}
- o=Ubuntu,a=${distro_codename}-updates
- o=Ubuntu,a=${distro_codename}-proposed-updates
unattended_updates_package_blacklist: []
unattended_updates_autofix_interrupted_dpkg: true
unattended_updates_minimal_steps: true
unattended_updates_install_on_shutdown: false
unattended_updates_mail: "{{ unattended_updates_mail_recipient | default('') }}"
unattended_updates_mail_only_on_error: true
unattended_updates_mail_report: only-on-error
unattended_updates_remove_unused_dependencies: true
unattended_updates_remove_new_unused_dependencies: true
unattended_updates_remove_unused_kernel_packages: true
unattended_updates_automatic_reboot: "{{ unattended_updates_automatic_reboot_enabled | default('true') }}"
unattended_updates_automatic_reboot_time: "{{ '02:' ~ '%02d' | format((range(0, 55) | random)) }}"
unattended_updates_ignore_apps_require_restart: false
unattended_updates_syslog_enable: true
unattended_updates_syslog_facility: updates
unattended_updates_update_package_list: 1
unattended_updates_autoclean_interval: 7
unattended_updates_clean_interval: 7
unattended_updates_verbose: 1
unattended_updates_random_sleep: 1800
unattended_updates_dpkg_options: []
unattended_updates_dl_limit: 0
unattended_updates_only_on_ac_power: false
```

## Example Playbook

```yaml
- name: Apply unattended_updates
  hosts: all
  become: true
  roles:
    - role: lenmail.default_server.unattended_updates
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/unattended_updates/tests/test.yml`.
