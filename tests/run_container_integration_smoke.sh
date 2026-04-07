#!/usr/bin/env bash
set -euo pipefail

IMAGE="${SMOKE_CONTAINER_IMAGE:?SMOKE_CONTAINER_IMAGE is required}"
CONTAINER_NAME="${SMOKE_CONTAINER_NAME:-lenmail-smoke}"
COLLECTION_ROOT="/tmp/ansible_collections/lenmail/default_server"

cleanup() {
  docker rm -f "${CONTAINER_NAME}" >/dev/null 2>&1 || true
}
trap cleanup EXIT

docker pull "${IMAGE}" >/dev/null
docker run --rm -d --name "${CONTAINER_NAME}" "${IMAGE}" sh -c 'trap "exit 0" TERM; while :; do sleep 5; done' >/dev/null

if docker exec "${CONTAINER_NAME}" test -f /etc/debian_version; then
  docker exec "${CONTAINER_NAME}" sh -lc 'apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y python3 python3-venv python3-pip sudo ca-certificates curl'
else
  docker exec "${CONTAINER_NAME}" sh -lc 'dnf install -y python3 python3-pip sudo ca-certificates curl findutils which tar gzip shadow-utils'
fi

docker exec "${CONTAINER_NAME}" mkdir -p /tmp/ansible_collections/lenmail
docker cp . "${CONTAINER_NAME}:${COLLECTION_ROOT}"

docker exec "${CONTAINER_NAME}" sh -lc "cd ${COLLECTION_ROOT} && python3 -m venv .venv && .venv/bin/pip install --upgrade pip && .venv/bin/pip install -r requirements-test.txt"
docker exec "${CONTAINER_NAME}" sh -lc "cd ${COLLECTION_ROOT} && .venv/bin/ansible-galaxy collection install -r requirements.yml"
docker exec "${CONTAINER_NAME}" sh -lc "cd ${COLLECTION_ROOT} && .venv/bin/ansible-playbook tests/integration/smoke.yml -i localhost, -c local"

docker exec "${CONTAINER_NAME}" sh -lc "cd ${COLLECTION_ROOT} && .venv/bin/ansible-playbook tests/integration/smoke.yml -i localhost, -c local | tee /tmp/lenmail-smoke-second-run.log"
docker exec "${CONTAINER_NAME}" sh -lc "grep -E 'changed=0 .*failed=0' /tmp/lenmail-smoke-second-run.log >/dev/null"
