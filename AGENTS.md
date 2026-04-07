# AGENTS.md

Dieses Repository enthaelt die Ansible Collection `lenmail.default_server`.

## Ziele

- Rollen fuer Ubuntu 22.04+, Debian 12+ und RHEL 9+ konsistent halten
- neue Rollen nur mit sauberem Standard-Geruest aufnehmen
- lokale Checks auf macOS reproduzierbar halten

## Pflicht fuer neue oder geaenderte Rollen

- `README.md` pro Rolle
- `meta/main.yml`
- `meta/argument_specs.yml`
- `tests/test.yml`
- Plattform-Support explizit dokumentieren
- keine impliziten Distribution-Annahmen ohne `assert` oder klares `when`

## Rollen-Standard

- Defaults muessen sicher und ohne versteckte Fremdvariablen nutzbar sein
- Rollen mit Diensten sollen Konfiguration vor Restart oder Enable validieren, wenn ein Validator verfuegbar ist
- Plattformspezifische Paketnamen, Pfade und Services gehoeren in `vars/`
- Neue Rollen sollen moeglichst `ansible.builtin.*` verwenden
- Secrets gehoeren nicht in Defaults, sondern muessen leer oder optional sein
- Service-, Firewall- und Netzwerkrrollen sollen offensichtliche Schalter wie `*_manage_firewall`, `*_service_enabled` oder gleichwertige Steuerung haben
- Rollen mit generierten Dateien sollen idempotent bleiben und veraltete Artefakte nach Moeglichkeit bereinigen

## Scaffold und Formatierung

- Rollen-Geruest wird ueber `tools/generate_role_scaffold.py` gepflegt
- YAML wird ueber `tools/format_yaml.py` vereinheitlicht
- Nach Struktur-Aenderungen immer ausfuehren:
  - `.venv/bin/python tools/generate_role_scaffold.py`
  - `.venv/bin/python tools/format_yaml.py`

## Lokale Toolchain

- Auf macOS die lokale `.venv` mit Homebrew `python@3.12` bauen
- Homebrew nicht mit `sudo` ausfuehren
- Beispiel:
  - `/opt/homebrew/opt/python@3.12/bin/python3.12 -m venv .venv`
  - `.venv/bin/pip install -r requirements-test.txt`

## Mindestchecks vor Commit

- `.venv/bin/python tools/generate_role_scaffold.py --check`
- `.venv/bin/pytest -q tests/unit`
- `PATH="$PWD/.venv/bin:$PATH" bash tests/run_role_syntax_checks.sh`
- `PATH="$PWD/.venv/bin:$PATH" ansible-lint`

## Plattform-Regeln

- `netplan`, `interfaces`, `ufw` nur Debian-Familie
- `ifcfg`, `firewalld` nur RedHat-Familie
- Rollen mit distributionsspezifischem Verhalten sollen das frueh validieren
- Wenn eine Rolle nicht sinnvoll plattformuebergreifend ist, lieber klar eingrenzen als implizit brechen

## Doku- und Namespace-Regeln

- Collection-Referenzen immer als `lenmail.default_server.*`
- keine neuen Verweise auf den alten Namespace oder alte Repository-Namen
- Beispiel-Playbooks und Rollen-READMEs nach jeder Namespace-Aenderung regenerieren
