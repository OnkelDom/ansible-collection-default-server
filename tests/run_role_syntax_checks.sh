#!/usr/bin/env bash
set -euo pipefail

for playbook in roles/*/tests/test.yml; do
  ansible-playbook --syntax-check "$playbook"
done
