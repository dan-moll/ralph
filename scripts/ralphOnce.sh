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

# Read the prompt content
PROMPT_CONTENT=$(cat "$PROMPT_FILE")

# Create the full prompt with file references
FULL_PROMPT="$PROMPT_CONTENT

Please read these files first before starting:
- plans/PRD.json (your feature backlog)
- plans/progress.txt (your memory from previous iterations)
- init.sh (how to start the project)
- git log --oneline -20 (recent commits)

Then follow the instructions above to pick and complete ONE task."

# Run Claude Code interactively
cd "$ROOT_DIR"
claude code "$FULL_PROMPT"

echo
echo "✅ Iteration complete. Run again to continue, or use ./scripts/ralph.sh for autonomous mode."
