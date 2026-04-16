# docker

Install Docker Engine from the official Docker repositories and manage daemon settings.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
docker_manage_repository: true
docker_remove_conflicting_packages: false
docker_manage_daemon_config: true
docker_manage_service: true
docker_service_enabled: true
docker_service_state: started
docker_users: []
docker_packages:
- docker-ce
- docker-ce-cli
- containerd.io
- docker-buildx-plugin
- docker-compose-plugin
docker_daemon_config: {}
```

## Example Playbook

```yaml
- name: Install and configure Docker Engine
  hosts: container_hosts
  become: true
  roles:
    - role: onkeldom.default_server.docker
      vars:
        docker_users:
          - deploy
        docker_daemon_config:
          log-driver: json-file
          log-opts:
            max-size: "10m"
            max-file: "3"
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/docker/tests/test.yml`.
