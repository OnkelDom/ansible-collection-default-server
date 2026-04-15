# nginx

Install and configure NGINX and virtual hosts.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
---
nginx_default_release: ''
nginx_yum_repo_enabled: true
nginx_zypper_repo_enabled: true
nginx_ppa_use: false
nginx_ppa_version: stable
nginx_package_name: nginx
nginx_manage_service: true
nginx_service_state: started
nginx_service_enabled: true
nginx_manage_firewall: false
nginx_firewall_zone: public
nginx_manage_selinux: true
nginx_firewall_ports:
- 80/tcp
- 443/tcp
nginx_conf_template: nginx.conf.j2
nginx_vhost_template: vhost.j2
nginx_worker_processes: '"{{ ansible_processor_vcpus | default(ansible_processor_count) }}"'
nginx_worker_connections: '1024'
nginx_multi_accept: off
nginx_error_log: /var/log/nginx/error.log warn
nginx_access_log: /var/log/nginx/access.log main buffer=16k flush=2m
nginx_sendfile: on
nginx_tcp_nopush: on
nginx_tcp_nodelay: on
nginx_keepalive_timeout: '75'
nginx_keepalive_requests: '600'
nginx_server_tokens: on
nginx_client_max_body_size: 64m
nginx_server_names_hash_bucket_size: '64'
nginx_proxy_cache_path: ''
nginx_extra_conf_options: ''
nginx_extra_http_options: ''
nginx_remove_default_vhost: false
nginx_listen_ipv6: true
nginx_vhosts: []
nginx_upstreams: []
nginx_log_format: "'$remote_addr - $remote_user [$time_local] \"$request\" '\n'$status $body_bytes_sent \"$http_referer\" '\n'\"$http_user_agent\" \"$http_x_forwarded_for\"'"
```

## Example Playbook

```yaml
- name: Apply nginx
  hosts: all
  become: true
  roles:
    - role: onkeldom.default_server.nginx
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/nginx/tests/test.yml`.
