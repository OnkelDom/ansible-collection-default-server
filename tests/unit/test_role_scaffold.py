from __future__ import annotations

import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))

from tools.generate_role_scaffold import build_role_files, iter_role_dirs, load_config  # noqa: E402


def test_generated_role_files_are_current() -> None:
    config = load_config()

    for role_dir in iter_role_dirs():
        generated = build_role_files(config, role_dir)
        for path, expected in generated.items():
            assert path.exists(), f"Missing generated file: {path}"
            assert path.read_text(encoding="utf-8") == f"{expected.rstrip()}\n"
