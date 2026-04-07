# certbot

Request and renew TLS certificates with Certbot.

## Supported platforms

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
certbot_cloudflare_api_email: '{{ cloudflare_api_email}}'
certbot_cloudflare_api_key: '{{ encrypted_cloudflare_api_key}}'
certbot_cloudflare_credentials_path: /etc/letsencrypt/cloudflare.ini
certbot_renew_hook: ''
certbot_certs:
- domains:
  - '{{ ansible_fqdn }}'
  services:
  - name: node_exporter
    action: restart
```

## Example Playbook

```yaml
- name: Apply certbot
  hosts: all
  become: true
  roles:
    - role: inframonks.default_server.certbot
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/certbot/tests/test.yml`.
