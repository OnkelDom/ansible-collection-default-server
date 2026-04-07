# Ansible Collection: `inframonks.default_server`

Diese Collection bundelt Basisrollen fuer Linux-Server und ist auf eine saubere, wiederholbare Rollenstruktur ausgelegt.
Jede Rolle erhaelt ein einheitliches Geruest mit:

- `README.md`
- `meta/main.yml`
- `meta/argument_specs.yml`
- `tests/test.yml`

## Zielplattformen

Die Collection ist auf folgende Baseline ausgerichtet:

- Ubuntu 22.04+
- Debian 12+
- RHEL 9+

Nicht jede Rolle ist auf jeder Plattform sinnvoll. Netzwerk- und Firewall-Rollen dokumentieren ihren effektiven Support jeweils im rollenlokalen `README.md` und in `meta/main.yml`.

## Rollen

Die Collection enthaelt unter anderem Rollen fuer:

- Basis-Systemeinstellungen: `chrony`, `hosts`, `motd`, `packages`, `sysctl`, `users`
- Netzwerk: `firewalld`, `ifcfg`, `interfaces`, `netplan`, `nmcli`, `resolvconf`, `ufw`
- Security: `auditd`, `fail2ban`, `sshd`, `sssd`
- Dienste und Tools: `borgbackup`, `certbot`, `nginx`, `node-exporter`, `postfix_mta`, `telegraf`
- Plattform-spezifische Helfer: `dnf_automatic`, `dnf_repos`, `qemu_guest_agent`, `vmware_tools`

## Installation

```bash
ansible-galaxy collection install git+https://github.com/inframonks/ansible-collection-default-server.git
```

Oder ueber eine `requirements.yml`:

```yaml
collections:
  - name: git+https://github.com/inframonks/ansible-collection-default-server.git
```

## Verwendung

```yaml
- name: Default server baseline
  hosts: all
  become: true
  roles:
    - role: inframonks.default_server.chrony
    - role: inframonks.default_server.users
```

## Entwicklung

Lokale Hilfsmittel:

- Collection-Abhaengigkeiten: `requirements.yml`
- Test-Abhaengigkeiten: `requirements-test.txt`
- Rollen-Generator: `tools/generate_role_scaffold.py`

Generator ausfuehren:

```bash
python3 tools/generate_role_scaffold.py
```

Drift pruefen:

```bash
python3 tools/generate_role_scaffold.py --check
```

## CI

GitHub Actions prueft automatisiert:

- `ansible-lint`
- `ansible-test sanity`
- Rollen-Geruest per `pytest`
- Syntax-Checks fuer jede Rolle

## Lizenz

MIT
