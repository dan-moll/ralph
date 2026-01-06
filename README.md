# Ralph 🐠

**Wake up to working code.** A file-based harness for long-running AI coding agents using Claude Code.

Ralph is like a goldfish: short memory, laser focus. Each iteration, it picks the highest priority task, builds it, tests it, commits it, and forgets about it. Simple, persistent, effective.

## What Ralph Does

Ralph runs in a loop:
1. Reads your PRD (product requirements) and progress log
2. Picks the highest priority incomplete task
3. Implements the feature completely
4. Runs tests to verify it works
5. Commits the working code
6. Moves to the next task

When all tasks pass, Ralph stops and notifies you.

## Quick Start

### Prerequisites

```bash
# Install Claude Code CLI
npm install -g @anthropic-ai/claude-code

# Verify installation
claude code --version
```

### Setup in Your Project

**1. Copy Ralph files into your project:**

```bash
# Clone Ralph template
git clone https://github.com/dan-moll/ralph.git
cd ralph

# Copy all Ralph files to your project
cp -r scripts/ prompts/ plans/ /path/to/your/project/
cp init.sh /path/to/your/project/
cp .gitignore /path/to/your/project/.gitignore

# Or copy just what you need:
# - scripts/      (ralph.sh, ralphOnce.sh, verify.sh, notify.sh)
# - prompts/      (initializer.md, coding_agent.md)
# - plans/        (PRD.json, progress.txt, state.json)
# - init.sh
```

**2. Navigate to your project and run the initializer:**

```bash
cd /path/to/your/project
claude code --prompt-file prompts/initializer.md
```

The initializer will:
- Configure `init.sh` with your project's setup commands
- Set up `scripts/verify.sh` with your test/lint/typecheck commands
- Create initial progress log
- Make an initial git commit

**3. Define your features in `plans/PRD.json`:**

```json
[
  {
    "id": "F-001",
    "category": "feature",
    "priority_hint": "P1",
    "description": "Add user authentication with email/password",
    "steps": [
      "Create auth API endpoints",
      "Add login form component",
      "Implement session management",
      "Add tests for auth flow"
    ],
    "passes": false,
    "notes": ""
  }
]
```

**4. Run Ralph:**

```bash
# Autonomous mode (let it work through entire backlog)
./scripts/ralph.sh

# Interactive mode (one task at a time)
./scripts/ralphOnce.sh
```

**5. Review results:**

```bash
# Check what was done
git log --oneline

# Review agent notes
cat plans/progress.txt

# Verify tests pass
./scripts/verify.sh
```

## Production Usage

### What Ralph Needs

- **Clear requirements**: Each PRD item should be specific and testable
- **Working tests**: Ralph verifies features work before marking complete
- **Small tasks**: Each task should complete in one iteration (~5-15 min)
- **Git repository**: Ralph commits after each completed task

### Environment Variables (if needed)

If your project needs API keys or env vars:

```bash
# Add to your project's .env file
ANTHROPIC_API_KEY=your_key_here
DATABASE_URL=your_db_url
# etc.

# Make sure init.sh loads these
echo "export $(cat .env | xargs)" >> init.sh
```

### Configuration

Edit `scripts/ralph.sh` to adjust settings:

```bash
# Maximum iterations before stopping (default: 30)
MAX_ITERS="${MAX_ITERS:-30}"

# Or override when running
MAX_ITERS=50 ./scripts/ralph.sh
```

## File Structure

```
your-project/
├── scripts/
│   ├── ralph.sh          # Autonomous loop runner
│   ├── ralphOnce.sh      # Interactive single-iteration runner
│   ├── verify.sh         # Test/lint/typecheck runner
│   └── notify.sh         # Optional completion notification
├── prompts/
│   ├── initializer.md    # First-run setup prompt
│   └── coding_agent.md   # Main loop agent prompt
├── plans/
│   ├── PRD.json          # Feature requirements (you edit this)
│   ├── progress.txt      # Agent's append-only memory
│   └── state.json        # Loop orchestration metadata
└── init.sh               # Project startup script
```

## Best Practices

**Keep tasks atomic and small:**
- ✅ "Add password reset endpoint with email notification"
- ❌ "Build entire authentication system"

**Write strong tests:**
- Ralph marks tasks complete based on passing tests
- TypeScript/types catch errors early
- Update `verify.sh` with project-specific checks

**Let Ralph commit frequently:**
- One task = one commit
- Easy to review, easy to revert
- Clear git history

**Review progress regularly:**
- Check `plans/progress.txt` for agent notes
- Adjust PRD priorities as needed
- Add new tasks anytime (Ralph will pick them up)

## Troubleshooting

**Ralph keeps failing the same task:**
- Task might be too big → break it into smaller pieces
- Tests might be flaky → fix tests first
- Requirements might be unclear → add more detail to PRD item

**Tests aren't running:**
- Check `scripts/verify.sh` is executable: `chmod +x scripts/verify.sh`
- Verify test commands work manually
- Ensure dependencies are installed via `init.sh`

**Ralph picked the wrong task:**
- Adjust `priority_hint` (P0 > P1 > P2 > P3)
- Mark blockers clearly in description
- Tasks are selected greedily: blockers → priority → size

## How It Works

Ralph uses three simple files for memory across iterations:

**`plans/PRD.json`** - Your feature backlog
- Each item has a `passes` flag (false = todo, true = done)
- Ralph flips `passes: true` only after tests pass

**`plans/progress.txt`** - Append-only agent memory
- Agent writes notes after each task
- Includes gotchas, learnings, suggestions
- Never rewritten, only appended to

**Git history** - Permanent record
- Each completed task = one commit
- Agent reads recent commits to understand context

The orchestration is just a bash for-loop. No complex agent meshes, no cloud dependencies. Simple, debuggable, reliable.

## Credits & Attribution

**Ralph is built on the shoulders of giants:**

- **Geoffrey Huntley** ([@ghuntley](https://github.com/ghuntley)) - Created the original "Ralph Wiggum" approach and methodology. Read his article: [ghuntley.com/fractal](https://ghuntley.com/fractal)
- **Anthropic** - Research on effective agent harnesses, file-based memory patterns, and initialization strategies. Read their guide: [Building Effective Agents](https://www.anthropic.com/research/building-effective-agents)
- **Matt Pocock** ([@mattpocockuk](https://twitter.com/mattpocockuk)) - Video walkthrough demonstrating Ralph in production. Watch: [AI Hero](https://aihero.dev)

The principle: simple, persistent, goldfish-like iteration.

---

**License:** MIT
**Maintained by:** [@dan-moll](https://github.com/dan-moll)
**Built with:** Claude Code (Anthropic)
