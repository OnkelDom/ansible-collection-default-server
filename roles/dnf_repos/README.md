# dnf_repos

Manage DNF repository definitions on EL systems.

## Supported platforms

- RHEL 9+

## Role Variables

The role interface is validated through `meta/argument_specs.yml`. Defaults are defined in `defaults/main.yml`.

```yaml
dnf_repos_remove_original: true
dnf_repos_list:
- name: baseos
  mirrorlist: https://mirrors.rockylinux.org/mirrorlist?arch=$basearch&repo=BaseOS-$releasever$rltype
  gpgcheck: 1
  enabled: 1
  gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Rocky-9
  gpgkey_url: https://dl.rockylinux.org/pub/rocky/RPM-GPG-KEY-Rocky-9
- name: appstream
  mirrorlist: https://mirrors.rockylinux.org/mirrorlist?arch=$basearch&repo=AppStream-$releasever$rltype
  gpgcheck: 1
  enabled: 1
  gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Rocky-9
  gpgkey_url: https://dl.rockylinux.org/pub/rocky/RPM-GPG-KEY-Rocky-9
- name: extras
  mirrorlist: https://mirrors.rockylinux.org/mirrorlist?arch=$basearch&repo=extras-$releasever$rltype
  gpgcheck: 1
  enabled: 1
  gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Rocky-9
  gpgkey_url: https://dl.rockylinux.org/pub/rocky/RPM-GPG-KEY-Rocky-9
- name: crb
  mirrorlist: https://mirrors.rockylinux.org/mirrorlist?arch=$basearch&repo=CRB-$releasever$rltype
  gpgcheck: 1
  enabled: 1
  gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Rocky-9
  gpgkey_url: https://dl.rockylinux.org/pub/rocky/RPM-GPG-KEY-Rocky-9
- name: epel
  baseurl: https://download.fedoraproject.org/pub/epel/$releasever/Everything/x86_64/
  gpgcheck: 1
  enabled: 1
  gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-9
  gpgkey_url: https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-9
```

## Example Playbook

```yaml
- name: Apply dnf_repos
  hosts: all
  become: true
  roles:
    - role: inframonks.default_server.dnf_repos
```

## Testing

The collection CI runs `ansible-lint`, `ansible-test sanity`, repository consistency tests, and per-role syntax checks using `roles/dnf_repos/tests/test.yml`.
