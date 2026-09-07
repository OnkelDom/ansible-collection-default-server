from pathlib import Path

import yaml


COLLECTION_ROOT = Path(__file__).resolve().parents[2]
SSHD_DEFAULTS = COLLECTION_ROOT / "roles" / "sshd" / "defaults" / "main.yml"


def test_sshd_defaults_support_codex_ios_remote_ssh() -> None:
    defaults = yaml.safe_load(SSHD_DEFAULTS.read_text(encoding="utf-8"))
    server_defaults = defaults["sshd_server_defaults"]

    assert server_defaults["HostKey"] == [
        "/etc/ssh/ssh_host_ed25519_key",
        "/etc/ssh/ssh_host_ecdsa_key",
        "/etc/ssh/ssh_host_rsa_key",
    ]

    ciphers = server_defaults["Ciphers"].split(",")
    assert "aes256-gcm@openssh.com" in ciphers
    assert "aes128-gcm@openssh.com" in ciphers
