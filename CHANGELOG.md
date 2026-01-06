# Agent Harness Optimization Changelog

## Summary
Optimized the agent harness to properly implement the "Ralph Wiggum" goldfish approach based on Geoffrey Huntley's methodology and the video transcript analysis.

## Key Changes

### 1. **ralph.sh** - Fixed Claude Code CLI invocation
**Before:** Placeholder TODO comment
**After:** Properly configured `claude code` command with:
- `--prompt-file` pointing to coding_agent.md
- `--important` flags for PRD.json, progress.txt, and init.sh
- Output piped to run logs for sentinel detection

**Impact:** The harness can now actually run autonomously

### 2. **coding_agent.md** - Enhanced with goldfish philosophy
**Added:**
- 🐠 Goldfish metaphor: short-term memory, focus on one task
- Explicit greedy prioritization logic (blockers > priority > quick wins)
- Strong emphasis on NEVER marking passes: true without test proof
- Structured progress.txt logging format with timestamps
- Clear rule: ONE feature per iteration

**Impact:** Agent behavior now matches Ralph's persistent-but-forgetful approach

### 3. **verify.sh** - Implemented actual feedback loop
**Before:** Placeholder with TODO comments
**After:** Working verification script that:
- Auto-detects project type (Node.js vs Python)
- Runs type checking (TypeScript/mypy)
- Runs linting (npm/pnpm lint, ruff/flake8)
- Runs tests (npm test, pytest)
- Exits with proper error codes

**Impact:** The feedback loop now keeps Ralph honest (critical for quality)

### 4. **initializer.md** - Clearer setup instructions
**Enhanced:**
- More explicit objectives with testing requirements
- Emphasis on making scripts idempotent and executable
- Clearer deliverable format with emoji indicators
- Added reminder about verify.sh configuration

**Impact:** First-time setup is more reliable

### 5. **ralphOnce.sh** - Added human-in-the-loop mode
**New file:** Interactive single-iteration script for:
- Learning how Ralph works
- Debugging and steering
- Difficult features requiring human oversight

**Impact:** Developers can now choose autonomous OR interactive mode

### 6. **README.md** - Comprehensive documentation
**Added:**
- Philosophy section explaining the goldfish approach
- Workflow with both autonomous and interactive modes
- Key success factors (small tasks, strong feedback loops, clear requirements)
- Best practices (do's and don'ts)
- Configuration examples
- Credits to Geoffrey Huntley and Anthropic

**Impact:** Users understand why and how to use the harness effectively

### 7. **.gitignore** - Ignore run logs
**Added:** Basic .gitignore to exclude .runs/ directory and OS files

**Impact:** Cleaner git status

## Core Principles Implemented

### The Goldfish Philosophy
- **Short-term memory:** Each iteration starts fresh
- **Greedy selection:** Pick highest priority, not first in list
- **One task only:** No context window overload
- **Verify before claiming:** Tests must pass to mark complete
- **Commit and forget:** Move on to next iteration

### Feedback Loop Emphasis
As emphasized in the transcript: "The feedback loop is sacred"
- Tests are mandatory before marking tasks complete
- TypeScript/strong typing recommended
- verify.sh must work for Ralph to work
- CI should stay green on every commit

### Task Sizing
- Small tasks = better code quality
- Each PRD item should complete in one iteration
- Easier to verify, easier to debug
- Matches how real engineers work (pick task from board, complete it, move on)

## What Makes This Work

1. **Simple orchestration:** Just a bash for-loop (no complex agent meshes)
2. **File-based memory:** PRD.json + progress.txt + git history
3. **Strong verification:** Tests catch errors early
4. **Atomic commits:** One feature = one commit
5. **Clear stopping condition:** PROMISE_COMPLETE_HERE sentinel

## Alignment with Professional Best Practices

Based on:
- Geoffrey Huntley's Ralph Wiggum article (July 2024)
- Anthropic's "Effective Harnesses for Long-Running Agents"
- Real-world engineering practices (sprint boards, incremental progress)

The modifications ensure the harness:
- Calls Claude Code correctly ✅
- Implements goldfish/Ralph behavior ✅
- Has working feedback loops ✅
- Supports both autonomous and interactive modes ✅
- Is well-documented for users ✅

---
Optimized: 2026-01-06
