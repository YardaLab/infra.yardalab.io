#!/usr/bin/env bash
set -euo pipefail

HOST="$1"
USER="${2:-root}"

if [[ -z "${HOST}" ]]; then
  echo "Usage: $0 <PBX_IP_OR_HOSTNAME> [ssh_user]"
  exit 1
fi

echo "== IYI-60 :: Non-blocking connectivity verification =="
echo "Target: ${USER}@${HOST}"
echo

echo "[1/4] SSH connectivity"
ssh -o BatchMode=yes -o ConnectTimeout=5 "${USER}@${HOST}" "echo 'SSH OK'"

echo
echo "[2/4] Outbound DNS"
ssh "${USER}@${HOST}" "getent hosts google.com || dig google.com || true"

echo
echo "[3/4] Outbound HTTPS"
ssh "${USER}@${HOST}" "curl -fsS https://example.com >/dev/null && echo HTTPS OK"

echo
echo "[4/4] Time / NTP sanity"
ssh "${USER}@${HOST}" "timedatectl status | sed -n '1,10p' || date"

echo
echo "== IYI-60 DONE (non-blocking sanity check passed) =="
