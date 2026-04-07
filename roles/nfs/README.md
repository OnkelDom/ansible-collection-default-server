# nfs

Configure NFS server exports and client mounts.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
nfs_exports: []
nfs_mounts: []
```

## Example Playbook

```yaml
- name: Apply nfs
  hosts: all
  become: true
  roles:
    - role: lenmail.default_server.nfs
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/nfs/tests/test.yml`.
