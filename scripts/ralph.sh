#!/usr/bin/env bash
set -euo pipefail

# ralph.sh
# A simple orchestration loop for a coding agent.
# - Invokes an agent CLI each iteration
# - Provides PRD + progress as "important files"
# - Stops when agent prints the sentinel string

MAX_ITERS="${MAX_ITERS:-30}"
SENTINEL="PROMISE_COMPLETE_HERE"

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PRD_FILE="$ROOT_DIR/plans/PRD.json"
PROGRESS_FILE="$ROOT_DIR/plans/progress.txt"
STATE_FILE="$ROOT_DIR/plans/state.json"
PROMPT_FILE="$ROOT_DIR/prompts/coding_agent.md"

mkdir -p "$ROOT_DIR/.runs"

echo "Starting Ralph loop (MAX_ITERS=$MAX_ITERS)"
echo "PRD: $PRD_FILE"
echo "Progress: $PROGRESS_FILE"
echo "Prompt: $PROMPT_FILE"
echo "Sentinel: $SENTINEL"
echo

for ((i=1; i<=MAX_ITERS; i++)); do
  echo "=== Iteration $i / $MAX_ITERS ==="
  RUN_LOG="$ROOT_DIR/.runs/run_$i.log"

  # Invoke Claude Code with the coding agent prompt and important context files
  # The agent will:
  #   - Read PRD + progress + git history
  #   - Greedily pick the highest priority failing item
  #   - Implement + verify with tests
  #   - Update PRD passes flag + append to progress
  #   - Make a git commit
  #

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

  cd "$ROOT_DIR"
  claude -p --permission-mode bypassPermissions "$FULL_PROMPT" | tee "$RUN_LOG"

  if grep -q "$SENTINEL" "$RUN_LOG"; then
    echo "Sentinel detected. Exiting."
    "$ROOT_DIR/scripts/notify.sh" "Agent run complete (iteration $i)"
    exit 0
  fi

  echo
done

echo "Reached MAX_ITERS without sentinel."
"$ROOT_DIR/scripts/notify.sh" "Agent run stopped (reached MAX_ITERS=$MAX_ITERS)"
exit 1
