#!/usr/bin/env bash
set -euo pipefail

# ralphOnce.sh
# Human-in-the-loop version of Ralph
# Runs ONE iteration interactively so you can observe and steer
# Great for learning Ralph's capabilities and debugging

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PRD_FILE="$ROOT_DIR/plans/PRD.json"
PROGRESS_FILE="$ROOT_DIR/plans/progress.txt"
PROMPT_FILE="$ROOT_DIR/prompts/coding_agent.md"

echo "🐠 Ralph (Interactive Mode)"
echo "Running ONE iteration..."
echo "PRD: $PRD_FILE"
echo "Progress: $PROGRESS_FILE"
echo

# Run Claude Code interactively (no tee to log file)
claude code \
  --prompt-file "$PROMPT_FILE" \
  --important "$PRD_FILE" \
  --important "$PROGRESS_FILE" \
  --important "$ROOT_DIR/init.sh"

echo
echo "✅ Iteration complete. Run again to continue, or use ./scripts/ralph.sh for autonomous mode."
