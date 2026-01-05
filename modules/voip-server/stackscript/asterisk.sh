#!/bin/bash
set -euxo pipefail

# ------------------------------------------------------------
# Asterisk PBX bootstrap (Linode StackScript)
# ------------------------------------------------------------

export DEBIAN_FRONTEND=noninteractive

echo "[*] Updating system"
apt-get update -y

echo "[*] Installing Asterisk"
apt-get install -y \
  asterisk \
  asterisk-core-sounds-en-wav \
  asterisk-moh-opsound-wav

echo "[*] Enabling Asterisk service"
systemctl enable asterisk
systemctl start asterisk

echo "[*] Asterisk version:"
asterisk -V || true

echo "[*] StackScript completed"
