#!/bin/bash
# Installs the REA (Reverse Engineer Anything) CLI in Claude Code cloud sessions
# and registers it as an MCP server plus skill for Claude Code.
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

if ! command -v rea >/dev/null 2>&1; then
  npm install --global rea-agents --no-fund --no-audit
fi
echo "rea $(rea --version) installed"

# Register REA with Claude Code (MCP server in ~/.claude.json and skill in
# ~/.claude/skills). Skipped when both are already in place.
if node -e 'const c=require(require("os").homedir()+"/.claude.json");process.exit(c.mcpServers&&c.mcpServers.rea?0:1)' 2>/dev/null \
  && [ -f "$HOME/.claude/skills/reverse-engineer-anything/SKILL.md" ]; then
  echo "rea already registered with Claude Code"
else
  rea setup --client claude_code --yes --json >/dev/null
  echo "rea registered with Claude Code"
fi
