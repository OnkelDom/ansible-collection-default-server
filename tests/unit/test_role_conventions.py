from __future__ import annotations

from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
ROLES_DIR = ROOT / "roles"
REQUIRED_FILES = (
    Path("README.md"),
    Path("defaults/main.yml"),
    Path("tasks/main.yml"),
    Path("meta/main.yml"),
    Path("meta/argument_specs.yml"),
    Path("tests/test.yml"),
)


def test_roles_follow_required_file_conventions() -> None:
    missing: list[str] = []

    for role_dir in sorted(path for path in ROLES_DIR.iterdir() if path.is_dir()):
        for relative_path in REQUIRED_FILES:
            target = role_dir / relative_path
            if not target.exists():
                missing.append(f"{role_dir.name}: missing {relative_path}")

    assert not missing, "\n".join(missing)
