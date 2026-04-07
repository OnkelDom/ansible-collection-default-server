from __future__ import annotations

from pathlib import Path

import yaml


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


def test_role_directory_names_use_underscores_only() -> None:
    invalid = sorted(path.name for path in ROLES_DIR.iterdir() if path.is_dir() and "-" in path.name)
    assert not invalid, f"Role directories must use underscores instead of hyphens: {', '.join(invalid)}"


def test_role_test_playbooks_gather_facts() -> None:
    invalid: list[str] = []

    for role_dir in sorted(path for path in ROLES_DIR.iterdir() if path.is_dir()):
        test_playbook = role_dir / "tests" / "test.yml"
        content = yaml.safe_load(test_playbook.read_text(encoding="utf-8"))

        if not isinstance(content, list) or not content:
            invalid.append(f"{role_dir.name}: tests/test.yml must contain at least one play")
            continue

        first_play = content[0]
        if not isinstance(first_play, dict) or first_play.get("gather_facts") is not True:
            invalid.append(f"{role_dir.name}: tests/test.yml must set gather_facts: true")

    assert not invalid, "\n".join(invalid)


def test_roles_using_ansible_facts_have_fact_aware_syntax_playbooks() -> None:
    invalid: list[str] = []

    for role_dir in sorted(path for path in ROLES_DIR.iterdir() if path.is_dir()):
        task_files = list((role_dir / "tasks").glob("*.yml"))
        uses_ansible_facts = any("ansible_" in path.read_text(encoding="utf-8") for path in task_files)
        if not uses_ansible_facts:
            continue

        test_playbook = role_dir / "tests" / "test.yml"
        content = yaml.safe_load(test_playbook.read_text(encoding="utf-8"))
        first_play = content[0] if isinstance(content, list) and content else {}
        if not isinstance(first_play, dict) or first_play.get("gather_facts") is not True:
            invalid.append(f"{role_dir.name}: uses ansible facts in tasks but tests/test.yml does not gather facts")

    assert not invalid, "\n".join(invalid)
