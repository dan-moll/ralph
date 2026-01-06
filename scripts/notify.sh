#!/usr/bin/env bash
set -euo pipefail

# notify.sh
# Purpose: optional completion notification hook.
# Replace with your own (Slack, iMessage, WhatsApp, email, etc).

MESSAGE="${1:-Run complete}"
echo "NOTIFY: $MESSAGE"
