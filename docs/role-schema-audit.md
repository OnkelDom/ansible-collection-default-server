# Rollen-Schema-Audit

Stand: 2026-04-10

Dieses Dokument bewertet den aktuellen Rollenbestand gegen das in `AGENTS.md` definierte gemeinsame Rollenschema.

## Kurzfazit

- Der Grundaufbau ist ueberraschend konsistent.
- Das Rollen-Geruest ist fuer alle 47 Rollen vorhanden: `README.md`, `meta/main.yml`, `meta/argument_specs.yml` und `tests/test.yml`.
- Die oeffentliche Variablen-API ist derzeit vollstaendig zwischen `defaults/main.yml` und `meta/argument_specs.yml` gespiegelt.
- Die groessten Schema-Luecken liegen nicht im Geruest, sondern in drei operativen Themen:
  - fehlende oder uneinheitliche Firewall-Unterstuetzung in portable Dienstrollen
  - fehlende SELinux-Verwaltung in RedHat-faehigen Dienstrollen
  - uneinheitliche Plattformvalidierung und Service-Steuerung

## Ergebnis nach Themen

### 1. Rollen-Geruest

Status: erfuellt

- 47 von 47 Rollen haben das erwartete Grundgeruest.
- Es gibt keine Rolle, der `README.md`, `meta/main.yml`, `meta/argument_specs.yml` oder `tests/test.yml` fehlt.

### 2. Variablenvertrag ueber `argument_specs`

Status: erfuellt

- Alle Default-Variablen sind in `meta/argument_specs.yml` abgebildet.
- Es gibt derzeit keine Drift zwischen Defaults und `argument_specs`.

Offene Beobachtung:

- Keine Rolle nutzt aktuell `required: true` in `argument_specs`.
- Das ist fuer viele Rollen in Ordnung, zeigt aber auch, dass fachlich zwingende Eingaben derzeit eher durch Laufzeitverhalten als durch den API-Vertrag modelliert werden.

### 3. Lauffaehige Defaults

Status: teilweise erfuellt

Positiv:

- Viele Rollen haben sichere Defaults oder sind im Default bewusst konservativ.
- Beispiele: `keepalived` startet im Default nicht automatisch, `squid` und `dante` haben abgeschaltete Firewall-Steuerung per Default, `wpad` und `sftp_server` sind mit leeren Listen zumindest idempotent ausfuehrbar.

Kritische Abweichungen:

- `sssd` ist im Default nicht wirklich lauffaehig, weil `sssd_join_domain: true` mit Platzhalterwerten wie `example.com` und leeren Join-Credentials kombiniert ist.
- Rollen mit fachlich verpflichtenden Betreiberdaten modellieren diese Pflicht derzeit nicht ueber `argument_specs`.

### 4. Plattformvalidierung

Status: teilweise erfuellt

Positiv:

- Viele portable Rollen validieren Debian- und RedHat-Familie explizit frueh in `tasks/main.yml`.

Schema-Luecke:

- Folgende Rollen haben keine fruehe `assert`- oder `fail`-basierte Plattformvalidierung in `tasks/main.yml`:
  - `apache`
  - `auditd`
  - `borgbackup`
  - `ca`
  - `chrony`
  - `dnf_automatic`
  - `fail2ban`
  - `hosts`
  - `lvm`
  - `motd`
  - `mounts`
  - `msmtp`
  - `multipath`
  - `nfs`
  - `packages`
  - `proxy`
  - `qemu_guest_agent`
  - `resolvconf`
  - `sshd`
  - `sysctl`
  - `unattended_updates`
  - `users`
  - `vmware_tools`

Bewertung:

- Nicht jede dieser Rollen ist fachlich akut gefaehrdet.
- Fuer das gemeinsame Schema ist diese Uneinheitlichkeit aber eine echte Drift-Quelle.

### 5. Service-Steuerung

Status: uneinheitlich

Positiv:

- Mehrere Rollen haben bereits nachvollziehbare Service-Parameter.
- Gute Muster zeigen insbesondere `dante`, `squid`, `haproxy`, `apache`, `nginx`, `keepalived`, `sftp_server` und `alloy`.

Schema-Luecken:

- Die Benennung ist noch nicht einheitlich.
- `alloy` verwendet `alloy_firewall_enabled` statt des gewuenschten Schemas `*_manage_firewall`.
- Mehrere Dienstrollen haben `*_service_enabled` und `*_service_state`, aber kein `*_manage_service`.
- Andere Rollen starten oder aktivieren Services hart ohne steuerbaren Schalter.

Rollen mit sichtbarer Service-Steuerung im Default:

- `alloy`
- `apache`
- `dante`
- `haproxy`
- `keepalived`
- `netplan`
- `nginx`
- `sftp_server`
- `squid`
- `wpad`

Rollen mit hart codierter Service-Aktivierung oder ohne einheitliches Service-Schema:

- `auditd`
- `chrony`
- `dnf_automatic`
- `fail2ban`
- `ifcfg`
- `interfaces`
- `multipath`
- `nmcli`
- `qemu_guest_agent`
- `sshd`
- `sssd`
- `systemd_timesyncd`
- `telegraf`
- `traefik`
- `unbound`
- `vmware_tools`

### 6. Firewall-Unterstuetzung

Status: groesste operative Luecke

Vollstaendig im Sinne des Schemas umgesetzt:

- `alloy`
- `dante`
- `squid`

Nur teilweise umgesetzt:

- `haproxy`: nur `firewalld`
- `unbound`: nur `firewalld`

Keine integrierte portable Firewall-Steuerung trotz Dienstcharakter:

- `apache`
- `nginx`
- `keepalived`
- `sftp_server`
- `sshd`
- `sssd`
- `telegraf`
- `traefik`
- `wpad`

Bewertung:

- Fuer portable Dienstrollen ist das derzeit nicht schema-konform.
- Besonders bei `apache`, `nginx`, `traefik`, `unbound`, `squid`, `dante`, `sshd` und `wpad` sollte die Rolle selbst optional `ufw` und `firewalld` bedienen koennen.

### 7. SELinux

Status: nicht umgesetzt

Befund:

- Im aktuellen Rollenbestand gibt es keine erkennbare Nutzung von SELinux-Primitiven wie `seboolean`, `sefcontext`, `seport`, `restorecon` oder vergleichbaren RedHat-spezifischen SELinux-Tasks.

Auswirkung:

- Das neue Schema wird hier aktuell von keiner RedHat-faehigen relevanten Dienstrolle erfuellt.

Besonders betroffen:

- `apache`
- `dante`
- `haproxy`
- `nginx`
- `node_exporter`
- `sftp_server`
- `squid`
- `sshd`
- `sssd`
- `telegraf`
- `traefik`
- `unbound`
- `wpad`

Hinweis:

- Nicht jede Rolle braucht zwingend SELinux-Anpassungen.
- Aber fuer jede offiziell RedHat-faehige Dienstrolle muss diese Frage kuenftig bewusst beantwortet und im Code oder in der Doku abgebildet werden.

## Prioritaeten fuer Nacharbeit

### Prioritaet 1

- `unbound`
  - portable Rolle, aber Firewall nur fuer `firewalld`
  - keine SELinux-Behandlung
  - Service-Steuerung noch ohne `*_manage_service`

- `squid`
  - Firewall bereits gut, aber keine SELinux-Behandlung
  - gutes Kandidat-Template fuer das kuenftige Standardschema

- `haproxy`
  - nur `firewalld`
  - keine SELinux-Behandlung

- `traefik`
  - keine integrierte Firewall-Steuerung
  - keine SELinux-Behandlung
  - Service wird hart gestartet

- `apache`
  - keine fruehe Plattformvalidierung
  - keine integrierte Firewall-Steuerung
  - keine SELinux-Behandlung

- `nginx`
  - keine integrierte Firewall-Steuerung
  - keine SELinux-Behandlung
  - Service-Steuerung ohne `*_manage_service`

### Prioritaet 2

- `sshd`
- `sftp_server`
- `sssd`
- `wpad`
- `telegraf`
- `alloy`

Gruende:

- portable Dienstrollen
- teilweise fehlende Firewall-Unterstuetzung
- keine SELinux-Behandlung
- uneinheitliche Service-Schalter

### Prioritaet 3

- Rollen ohne fruehe Plattformvalidierung
- Rollen mit hart codierter Service-Aktivierung
- Rollen, die zwar lauffaehig sind, aber noch kein vollstaendig standardisiertes `manage_service`- oder `manage_firewall`-Schema haben

## Empfehlung fuer das weitere Vorgehen

Die Nacharbeit sollte nicht rolleweise zufaellig, sondern in Standardschritten passieren:

1. Referenzmuster fuer portable Dienstrollen festlegen.
   Das Referenzmuster sollte `argument_specs`, lauffaehige Defaults, `*_manage_service`, `*_service_enabled`, `*_service_state`, `*_manage_firewall`, `ufw`, `firewalld`, Konfigurationsvalidierung und optionale SELinux-Hooks enthalten.

2. Referenzrollen zuerst vereinheitlichen.
   Empfohlene Startrollen:
   - `squid`
   - `unbound`
   - `haproxy`
   - `traefik`

3. Danach die uebrigen Edge- und Dienstrollen auf dasselbe Schema ziehen.
   - `apache`
   - `nginx`
   - `dante`
   - `sshd`
   - `sftp_server`
   - `wpad`

4. Danach die restlichen System- und Agent-Rollen vereinheitlichen.

## Audit-Entscheidung

Der Rollenbestand ist formal gut gepflegt, aber operativ noch nicht voll auf dem neuen Standardschema. Der groesste Mehrwert liegt jetzt nicht im Scaffold, sondern in der Vereinheitlichung von:

- Service-Steuerung
- Firewall-Steuerung
- SELinux-Unterstuetzung
- frueher Plattformvalidierung
