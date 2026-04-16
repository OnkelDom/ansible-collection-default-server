#!/usr/bin/env bash
set -euo pipefail

ROLE_NAME="${1:?role name is required}"
IMAGE="${2:?container image is required}"
PLAYBOOK="roles/${ROLE_NAME}/tests/functional.yml"
CONTAINER_NAME="${ROLE_NAME//_/-}-functional-${GITHUB_RUN_ID:-local}"
COLLECTION_ROOT="/tmp/ansible_collections/onkeldom/default_server"
PYTHON_BIN="python3"

cleanup() {
  docker rm -f "${CONTAINER_NAME}" >/dev/null 2>&1 || true
}
trap cleanup EXIT

docker pull "${IMAGE}" >/dev/null
docker run --rm -d --name "${CONTAINER_NAME}" "${IMAGE}" sh -c 'trap "exit 0" TERM; while :; do sleep 5; done' >/dev/null

if docker exec "${CONTAINER_NAME}" test -f /etc/debian_version; then
  docker exec "${CONTAINER_NAME}" sh -lc 'apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y python3 python3-venv python3-pip sudo ca-certificates curl'
else
  PYTHON_BIN="python3.11"
  docker exec "${CONTAINER_NAME}" sh -lc 'dnf install -y python3.11 python3.11-pip sudo ca-certificates curl findutils which tar gzip shadow-utils'
fi

docker exec "${CONTAINER_NAME}" mkdir -p /tmp/ansible_collections/onkeldom
docker cp . "${CONTAINER_NAME}:${COLLECTION_ROOT}"

docker exec "${CONTAINER_NAME}" sh -lc "cd ${COLLECTION_ROOT} && ${PYTHON_BIN} -m venv .venv && .venv/bin/pip install --upgrade pip && .venv/bin/pip install -r requirements-test.txt"
docker exec "${CONTAINER_NAME}" sh -lc "cd ${COLLECTION_ROOT} && .venv/bin/ansible-galaxy collection install -r requirements.yml"
docker exec "${CONTAINER_NAME}" sh -lc "cd ${COLLECTION_ROOT} && .venv/bin/ansible-galaxy collection build --force && .venv/bin/ansible-galaxy collection install onkeldom-default_server-*.tar.gz --force"

docker exec "${CONTAINER_NAME}" sh -lc "cd ${COLLECTION_ROOT} && ANSIBLE_COLLECTIONS_PATH=/root/.ansible/collections .venv/bin/ansible-playbook ${PLAYBOOK} -i localhost, -c local"
docker exec "${CONTAINER_NAME}" sh -lc "cd ${COLLECTION_ROOT} && ANSIBLE_COLLECTIONS_PATH=/root/.ansible/collections .venv/bin/ansible-playbook ${PLAYBOOK} -i localhost, -c local | tee /tmp/${ROLE_NAME}-second-run.log"
docker exec "${CONTAINER_NAME}" sh -lc "grep -E 'changed=0 .*failed=0' /tmp/${ROLE_NAME}-second-run.log >/dev/null"
