#!/bin/bash
# Installs the REA (Reverse Engineer Anything) CLI in Claude Code cloud sessions.
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

if command -v rea >/dev/null 2>&1; then
  echo "rea $(rea --version) already installed"
  exit 0
fi

npm install --global rea-agents --no-fund --no-audit
echo "rea $(rea --version) installed"
