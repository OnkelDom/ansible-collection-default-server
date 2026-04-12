# AGENTS.md

Dieses Repository enthaelt die Ansible Collection `lenmail.default_server`.

Das Ziel dieses Dokuments ist nicht nur Stil vorzugeben, sondern eine belastbare Arbeitsdefinition fuer den gesamten Rollenbestand festzulegen. Es beschreibt, wie wir Rollen einordnen, aendern, reviewen, testen und bei Plattformunterschieden stabil halten.

## Leitbild

- Jede Rolle hat einen klaren Infrastrukturzweck und keine versteckte Seiteneffekte ausserhalb ihres Verantwortungsbereichs.
- Jede Rolle ist fuer Ubuntu 22.04+, Debian 12+ und RHEL 9+ entweder explizit unterstuetzt oder explizit ausgeschlossen.
- Plattformlogik wird bewusst modelliert, nicht implizit durch zufaellig funktionierende Paketnamen oder Pfade.
- Defaults muessen fuer Operatoren lesbar, sicher und ohne nicht dokumentierte Fremdvariablen nutzbar sein.
- Die Collection wird aus Sicht eines DevOps- und Systemarchitektur-Teams betrieben: reproduzierbar, validierbar, idempotent und wartbar.

## Repo-Ziele

- Rollen fuer Ubuntu 22.04+, Debian 12+ und RHEL 9+ konsistent halten.
- Neue Rollen nur mit sauberem Standard-Geruest aufnehmen.
- Lokale Checks auf macOS reproduzierbar halten.
- Unterschiede zwischen Paketmanagern, Firewalls, Netzstacks und Service-Layouts architektonisch sauber kapseln.

## Rollen-Vertrag

Jede neue oder geaenderte Rolle muss diese Minimalanforderungen erfuellen:

- `README.md` pro Rolle
- `meta/main.yml`
- `meta/argument_specs.yml`
- `tests/test.yml`
- Plattform-Support explizit dokumentieren
- keine impliziten Distribution-Annahmen ohne `assert`, fruehes `when` oder OS-spezifische `vars/`
- Defaults ohne Secrets
- idempotente Tasks
- nachvollziehbare Service-Steuerung
- `meta/argument_specs.yml` ist der verbindliche Variablenvertrag der Rolle und sichert die oeffentliche API gegen ungueltige oder unvollstaendige Eingaben ab

## Rollen-Standard

- Neue Rollen sollen moeglichst `ansible.builtin.*` verwenden.
- Paketnamen, Pfade, Service-Namen, Validator-Binaries und Repo-URLs gehoeren in `vars/`.
- Rollen mit Diensten validieren Konfiguration vor Restart oder Enable, wenn ein Validator verfuegbar ist.
- Rollen mit Netzwerk- oder Firewall-Eingriffen brauchen offensichtliche Schalter wie `*_manage_firewall`, `*_manage_service`, `*_service_enabled` oder gleichwertige Steuerung.
- Rollen mit generierten Dateien muessen veraltete Artefakte nach Moeglichkeit entfernen.
- Rollen duerfen `ansible_*` Facts voraussetzen, aber Beispiel-Playbooks und Syntax-Tests muessen `gather_facts: true` setzen.
- Fakten werden auf Play-Ebene gesammelt, nicht ueber pauschales `setup` in jeder Rolle.
- Wenn eine Rolle nicht sinnvoll plattformuebergreifend ist, wird sie klar eingegrenzt statt halb-portabel gehalten.
- Defaults muessen so definiert sein, dass eine Rolle mit ihren Standardwerten lauffaehig ist. Ausnahme: wenn die Fachlichkeit zwingend Pflichtdaten verlangt, muessen diese Variablen in `argument_specs` und README klar als erforderlich beschrieben werden.
- Relevante Anwendungen und Dienste sollen ihre SELinux-Kontexte, Booleans, Ports und Policy-Anforderungen beim Rollout selbst setzen, wenn die Rolle auf RedHat-Familie unterstuetzt wird und SELinux fuer den Dienst fachlich relevant ist.
- Dienstrollen sollen Firewall-Freischaltungen fuer Debian-Familie und RedHat-Familie grundsaetzlich selbst unterstuetzen, also `ufw` und `firewalld`, sofern die Rolle Netzwerkports nach aussen oeffnet und dies fachlich sinnvoll ist.

## Verbindliches Rollen-Schema

Jede Rolle soll nach demselben technischen Muster aufgebaut werden. Abweichungen muessen begruendbar sein.

### 1. Rollen-API

- Alle oeffentlichen Variablen stehen in `defaults/main.yml`.
- Alle oeffentlichen Variablen werden in `meta/argument_specs.yml` beschrieben und typisiert.
- Pflichtvariablen sind nur erlaubt, wenn die Rolle ohne sie fachlich keinen sinnvollen Default haben kann.
- Interne Hilfsvariablen und OS-spezifische Ableitungen gehoeren nicht in die oeffentliche API, sondern in `vars/`.

### 2. Lauffaehige Defaults

- Standardwerte muessen einen sicheren, idempotenten und lauffaehigen Rollout ermoeglichen.
- Eine Rolle darf im Default keine externen Geheimnisse voraussetzen.
- Wenn ein Dienst ohne echte Konfiguration nicht sinnvoll gestartet werden darf, muss der Default diesen Dienst entweder deaktiviert lassen oder durch Assertions einen klaren Operator-Fehler erzeugen.
- "Leer aber gueltig" ist besser als "stillschweigend kaputt".

### 3. Plattformschicht

- Paketnamen, Pfade, Service-Namen, Validatoren, SELinux-spezifische Werte und Firewall-Details liegen in `vars/`.
- Tasks, Templates und Handler referenzieren diese abstrahierten Variablen statt Distributionen direkt, wo immer das praktikabel ist.
- Plattformvalidierung passiert frueh in `tasks/main.yml`.

### 4. Dienststeuerung

- Dienstrollen haben wenn sinnvoll `*_manage_service`, `*_service_enabled` und `*_service_state`.
- Konfiguration wird vor Reload oder Restart validiert, wenn ein geeignetes Binary oder Tool vorhanden ist.
- Handler sollen nur das tun, was nach erfolgreicher Konfigurationsaenderung fachlich notwendig ist.

### 5. Firewall

- Dienstrollen mit exponierten Ports bieten standardisierte Firewall-Steuerung.
- Debian-Familie: `ufw`
- RedHat-Familie: `firewalld`
- Die Steuerung ist standardmaessig abschaltbar, typischerweise ueber `*_manage_firewall: false`.
- Wenn eine Rolle keine Portfreischaltung vornimmt, muss das eine bewusste Entscheidung sein und im README erkennbar bleiben.

### 6. SELinux

- Rollen fuer RedHat-Familie pruefen, ob der Dienst SELinux-relevante Anforderungen hat.
- Wenn Ports, Dateikontexte, Booleans oder Label fuer den Dienst erforderlich sind, setzt die Rolle diese selbst.
- SELinux darf nicht als manuelle Nacharbeit beim Operator liegen bleiben, wenn die Rolle den Dienst offiziell fuer RHEL 9 unterstuetzt.
- Wenn SELinux bewusst nicht durch die Rolle verwaltet wird, muss das in README und AGENT-konformer Architekturentscheidung dokumentiert sein.

### 7. Idempotenz und Bereinigung

- Generierte Dateien muessen deterministisch sein.
- Veraltete Artefakte werden entfernt, wenn die Rolle die Quelle der Wahrheit fuer dieses Verzeichnis oder diese Dateifamilie ist.
- Tasks duerfen bei wiederholter Ausfuehrung keine Drift erzeugen.

### 8. Tests und Doku

- `tests/test.yml` muss die Rolle mit `gather_facts: true` einbinden.
- README, `meta/main.yml`, Defaults und `argument_specs` muessen dieselbe API und dieselben Plattformaussagen transportieren.
- Beispiel-Playbooks sollen das vorgesehene Betreiberverhalten zeigen, nicht nur irgendein Minimalbeispiel.

## Plattform-Modell

Wir pflegen drei Support-Stufen:

- `portable`: Rolle soll auf Debian-Familie und RedHat-Familie konsistent funktionieren.
- `family-scoped`: Rolle gilt absichtlich nur fuer genau eine OS-Familie.
- `distro-scoped`: Rolle gilt absichtlich nur fuer einzelne Distributionen innerhalb einer Familie.

Regeln dazu:

- `portable` Rollen brauchen fruehe Plattformvalidierung und OS-spezifische `vars/`.
- `family-scoped` Rollen muessen Meta, README, Assertions und Tasks auf dieselbe Familie ausrichten.
- `distro-scoped` Rollen muessen die Begrenzung begruenden, nicht nur zufaellig so implementiert sein.
- Was `meta/main.yml`, `README.md`, `assert` und `vars/` sagen, muss dieselbe Wahrheit beschreiben.

## Umgang mit Plattformunterschieden

- `netplan`, `interfaces`, `ufw`, `systemd_resolved`, `systemd_timesyncd`, `apt_repos`, `unattended_updates` sind Debian-seitig zu behandeln.
- `ifcfg`, `firewalld`, `dnf_repos`, `dnf_automatic` sind RedHat-seitig zu behandeln.
- Rollen mit `portable` Anspruch duerfen Debian-Pfade nicht in Templates, Handlern oder Validierungsbefehlen hart codieren.
- Rollen mit `portable` Anspruch duerfen RedHat-spezifische Paket- oder Service-Namen nicht in Defaults verstecken.
- OS-spezifische Includes folgen bevorzugt einem einheitlichen `include_vars`-Muster mit `with_first_found`, wenn mehr als eine Plattformvariante gepflegt wird.

## Rolle-Klassen

Der aktuelle Rollenbestand wird architektonisch in diese Klassen eingeordnet.

### Basis und Baseline

- `hosts`: Hostnamen- und `/etc/hosts`-Grundlagen
- `motd`: Login- und Betriebsinformationen
- `packages`: Basispaketmanagement ueber Familien hinweg
- `proxy`: systemweite Proxy-Umgebungswerte
- `users`: lokale Benutzer, Gruppen und Sudo
- `mounts`: generische Mount-Definitionen
- `lvm`: Volume-Management
- `sysctl`: Kernel-Tuning
- `ca`: Trust-Store und Zertifikats-Baseline

### Repositories und Updates

- `apt_repos`: Debian/Ubuntu Paketquellen
- `dnf_repos`: RHEL Paketquellen
- `dnf_automatic`: automatische DNF-Updates
- `unattended_updates`: automatische APT-Updates

### Netzwerk und Namensaufloesung

- `netplan`: modernes Debian/Ubuntu Netzwerk-Rendering
- `interfaces`: klassisches Debian-Netzwerk ueber ifupdown
- `ifcfg`: klassisches RedHat-Netzwerk
- `nmcli`: NetworkManager-Steuerung
- `resolvconf`: Resolver-Dateipflege
- `systemd_resolved`: Resolver-Dienst auf Debian-Familie
- `systemd_timesyncd`: einfache Zeitsynchronisation auf Debian-Familie
- `chrony`: portable NTP/Zeitsynchronisation
- `wpad`: PAC/WPAD-Bereitstellung
- `unbound`: DNS-Resolver

### Security und Zugang

- `sshd`: OpenSSH-Daemon
- `sftp_server`: eingeschraenkte SFTP-Bereitstellung
- `sssd`: zentrale Identitaetsanbindung
- `fail2ban`: brute-force Schutz
- `ufw`: Debian-Firewall
- `firewalld`: RedHat-Firewall
- `auditd`: Audit-Subsystem

### Proxy, Edge und Dienste

- `apache`: Webserver
- `nginx`: Webserver und Reverse Proxy
- `haproxy`: L4/L7 Load Balancer
- `traefik`: Edge Proxy
- `squid`: HTTP-Proxy
- `dante`: SOCKS-Proxy
- `keepalived`: VIP/Failover
- `certbot`: ACME/Let's Encrypt

### Observability und Agents

- `alloy`: Telemetrie-Agent
- `node_exporter`: Prometheus Node Exporter
- `telegraf`: Metrik-Agent
- `qemu_guest_agent`: VM-Integration fuer QEMU
- `vmware_tools`: VM-Integration fuer VMware

### Storage, Backup und Infrastrukturintegration

- `nfs`: NFS Client und Server-Anteile je nach Rolleingang
- `multipath`: Multipath-Storage
- `borgbackup`: Backup-Agent
- `msmtp`: SMTP-Relay fuer Systemmail

## Umgang mit jeder Rollen-Klasse

### Basis- und Baseline-Rollen

- Diese Rollen sollen moeglichst frueh in einem Host-Lifecycle laufen.
- Sie duerfen keine schwergewichtigen Netzwerkdienste implizit aktivieren.
- Sie sind konservativ zu aendern, weil sie viele andere Rollen indirekt beeinflussen.

### Repo- und Update-Rollen

- Diese Rollen sind die Quelle fuer Paketverfuegbarkeit und muessen vor dienstnahen Rollen sauber etabliert sein.
- Sie duerfen keine Fremdrepositories stillschweigend aktivieren, ohne dass Quelle und Zweck klar in Defaults und README benannt sind.
- Entfernen oder Ueberschreiben vorhandener Repo-Dateien braucht immer einen klaren Schalter und idempotente Bereinigung.

### Netzwerk-Rollen

- Genau eine primaere Netzwerkrolle soll ein Interface verwalten.
- `netplan`, `interfaces`, `ifcfg` und `nmcli` duerfen nicht unkoordiniert denselben Hostpfad oder dieselbe Schnittstelle steuern.
- Resolver-Rollen muessen offenlegen, ob sie `resolv.conf`, `systemd-resolved`, lokale Stub-Resolver oder Nameserver-Reihenfolge beeinflussen.

### Security-Rollen

- Diese Rollen brauchen sichere Defaults und duerfen keinen Zugang unabsichtlich oeffnen.
- Firewall-Rollen und Dienst-Rollen muessen Verantwortungsgrenzen klar halten: entweder steuert die Dienstrolle Ports optional selbst, oder die dedizierte Firewall-Rolle ist die Quelle der Wahrheit.
- SSH-, SFTP- und SSSD-Aenderungen brauchen besonders saubere Konfigurationsvalidierung, da sie Remote-Zugriff direkt betreffen.
- SELinux-relevante Security-Rollen auf RedHat-Familie duerfen notwendige SELinux-Anpassungen nicht auf manuelle Runbooks auslagern.

### Proxy-, Edge- und Service-Rollen

- Diese Rollen brauchen explizite Service- und Firewall-Schalter.
- Konfigurationsrendering ohne Validierung ist nur akzeptabel, wenn das Zielsystem keinen Validator anbietet.
- Listener, Zertifikate, ACLs und Include-Verzeichnisse sind API der Rolle und muessen als solche dokumentiert werden.
- Rollen dieser Klasse sollen `ufw` und `firewalld` beide bedienen koennen, wenn sie fuer beide Familien unterstuetzt werden.
- Rollen dieser Klasse sollen SELinux-relevante Ports und Kontexte auf RedHat-Familie selbst behandeln, sofern der Dienst offiziell unterstuetzt wird.

### Agent- und Observability-Rollen

- Diese Rollen muessen nicht nur installieren, sondern Deinstallation, Service-Aktivierung und Konfigurationsaenderungen kontrollierbar machen.
- Externe Paketquellen, GPG-Keys und Binaries sind als Supply-Chain-Risiko zu behandeln und gehoeren in klar benannte Variablen.

### Storage- und Integrationsrollen

- Diese Rollen greifen tief ins System ein und muessen Assertions, Guard Rails und saubere Defaults haben.
- Storage-Rollen duerfen nie stillschweigend destructive Re-Konfigurationen ausloesen.

## Erwartung pro Rolle

Fuer jede Rolle gilt bei Review und Aenderungen dieselbe Checkliste:

- Ist der Scope der Rolle klar und eng genug?
- Stimmen `meta/main.yml`, `README.md`, Defaults, `argument_specs` und Tasks inhaltlich ueberein?
- Ist Plattformverhalten explizit und frueh validiert?
- Liegen Paketnamen, Pfade, Service-Namen und Validatoren in `vars/` statt in Templates oder Tasks?
- Sichert `meta/argument_specs.yml` die komplette oeffentliche Rollen-API sinnvoll ab?
- Sind Defaults mit Standardwerten lauffaehig oder ist eine notwendige Pflichtvariable sauber als solche modelliert?
- Gibt es fuer Dienste eine sichere und steuerbare Service- und Firewall-Logik?
- Gibt es fuer exponierte Dienste sowohl Debian- als auch RedHat-Firewall-Unterstuetzung, wenn die Rolle beide Familien unterstuetzt?
- Sind notwendige SELinux-Anpassungen Bestandteil der Rolle statt manueller Nacharbeit?
- Werden Konfigurationsdateien vor Neustart validiert?
- Bleiben Dateien und Handler idempotent?
- Entfernt die Rolle veraltete Artefakte dort, wo sie die Quelle der Wahrheit ist?
- Ist die Rolle fuer lokale Syntax-Checks und Beispiel-Playbooks mit `gather_facts: true` geeignet?

## Definition des Umgangs mit dem aktuellen Rollenbestand

So wollen wir den vorhandenen Bestand kuenftig behandeln:

- `portable` und strategisch wichtig: `alloy`, `apache`, `auditd`, `borgbackup`, `ca`, `certbot`, `chrony`, `dante`, `fail2ban`, `haproxy`, `hosts`, `keepalived`, `lvm`, `mounts`, `msmtp`, `multipath`, `nfs`, `nginx`, `nmcli`, `node_exporter`, `packages`, `proxy`, `qemu_guest_agent`, `resolvconf`, `sftp_server`, `squid`, `sshd`, `sssd`, `sysctl`, `telegraf`, `traefik`, `unbound`, `users`, `vmware_tools`, `wpad`.
- `family-scoped` Debian: `apt_repos`, `interfaces`, `netplan`, `systemd_resolved`, `systemd_timesyncd`, `ufw`, `unattended_updates`.
- `family-scoped` RedHat: `dnf_automatic`, `dnf_repos`, `firewalld`, `ifcfg`.
- Rollen mit moeglichem Architekturabgleich bei Gelegenheit: `proxy`, `resolvconf`, `systemd_resolved`, `unbound`, `wpad`, weil sie alle in denselben DNS- oder Proxy-Fluss eingreifen koennen.
- Rollen mit hohem Kompositionsrisiko: `netplan`, `interfaces`, `ifcfg`, `nmcli`, `ufw`, `firewalld`, `keepalived`, `haproxy`, `nginx`, `apache`, `traefik`, `unbound`, `squid`, `dante`.

## Aenderungsregeln fuer bestehende Rollen

- Keine Rolle wird in einem einzelnen Change gleichzeitig funktional erweitert, umbenannt und architektonisch refaktoriert.
- Plattformbereinigung geht vor Feature-Ausbau.
- Wenn eine Rolle bereits Service- und Firewall-Logik besitzt, wird diese erst vereinheitlicht, bevor weitere Sonderfaelle dazukommen.
- Wenn eine portable Dienstrolle nur `ufw` oder nur `firewalld` implementiert, ist das technische Schuld und nicht der Zielzustand.
- Wenn eine portable RedHat-faehige Dienstrolle SELinux-relevante Schritte braucht, gehoeren diese in die Rolle.
- Wenn eine Rolle versteckte Kopplungen zu einer anderen Rolle hat, wird diese Kopplung dokumentiert oder entfernt.
- Wenn ein Verhalten nur fuer Debian oder nur fuer RedHat gilt, gehoert diese Wahrheit in Meta, README und Assertions.

## Neue Rollen

Neue Rollen werden nur aufgenommen, wenn:

- der Scope nicht bereits durch eine bestehende Rolle besser abgedeckt ist
- die Rolle in eine der bestehenden Klassen passt oder eine neue Klasse begruendet
- Plattform-Support vorab entschieden ist
- ein konsistentes Rollen-Geruest ueber `tools/generate_role_scaffold.py` erzeugt wurde

## Scaffold und Formatierung

- Rollen-Geruest wird ueber `tools/generate_role_scaffold.py` gepflegt.
- YAML wird ueber `tools/format_yaml.py` vereinheitlicht.
- Nach Struktur-Aenderungen immer ausfuehren:
  - `.venv/bin/python tools/generate_role_scaffold.py`
  - `.venv/bin/python tools/format_yaml.py`

## Lokale Toolchain

- Auf macOS die lokale `.venv` mit Homebrew `python@3.12` bauen.
- Homebrew nicht mit `sudo` ausfuehren.
- Beispiel:
  - `/opt/homebrew/opt/python@3.12/bin/python3.12 -m venv .venv`
  - `.venv/bin/pip install -r requirements-test.txt`

## Mindestchecks vor Commit

- `.venv/bin/python tools/generate_role_scaffold.py --check`
- `.venv/bin/pytest -q tests/unit`
- `PATH="$PWD/.venv/bin:$PATH" bash tests/run_role_syntax_checks.sh`
- `PATH="$PWD/.venv/bin:$PATH" ansible-lint`
- bei CI-Aenderungen auch `bash -n tests/run_container_integration_smoke.sh`

## Doku- und Namespace-Regeln

- Collection-Referenzen immer als `lenmail.default_server.*`
- keine neuen Verweise auf den alten Namespace oder alte Repository-Namen
- Beispiel-Playbooks und Rollen-READMEs nach jeder Namespace-Aenderung regenerieren
- README und Meta duerfen keine Plattformen oder Verhaltensweisen behaupten, die Tasks real nicht abbilden

## Zusammenarbeit bei AGENTS.md

Dieses Dokument ist absichtlich normativ und darf weitergeschaerft werden. Aenderungen an `AGENTS.md` sollen kuenftig vor allem diese Fragen beantworten:

- Welche Rollen sind strategisch und muessen plattformsauber gehalten werden?
- Welche Rollen sind bewusst familiespezifisch und sollen es bleiben?
- Welche Rollen ueberschneiden sich funktional und brauchen klare Verantwortungsgrenzen?
- Welche Service-, Netzwerk- und Security-Rollen brauchen strengere Review-Kriterien als der Rest?
