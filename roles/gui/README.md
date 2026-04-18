# gui

Install a graphical desktop environment on supported systems and switch the default boot target to `graphical.target`.

## Supported platforms

- Debian 12+
- Ubuntu 22.04+
- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

## Behavior

- Debian-family systems install `task-xfce-desktop` and `firefox-esr`
- Red Hat-family systems install the `Server with GUI` group plus `firefox`
- All supported systems switch the default systemd target to `graphical.target`
