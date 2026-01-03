# Verify connectivity (non-blocking) — IYI-60

This runbook describes a lightweight sanity check performed after
attaching a firewall to the PBX server.

## Scope
- SSH access verification
- Outbound DNS connectivity
- Outbound HTTPS connectivity
- System time / NTP sanity

## Non-goals
- SIP trunk registration
- RTP media testing
- Call-level validation

## How to run
From a trusted source (DEV workstation / Codespace):

```bash
./scripts/verify_pbx_connectivity.sh <PBX_IP> [ssh_user]
