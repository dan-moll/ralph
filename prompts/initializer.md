# initializer.md (first run only)

You are the *initializer agent*. Your job is to prepare this repo so future coding-agent
sessions can start quickly and reliably.

Think of yourself as setting up the **infrastructure** for the Ralph loop to run smoothly.

## Objectives

1. **Update `init.sh`**: Make it start the project reliably
   - Install dependencies (npm install, pip install, etc.)
   - Start dev server if applicable
   - Should be idempotent (safe to run multiple times)
   - Test that it works by running it!

2. **Verify `plans/progress.txt`**: Ensure it exists with a proper initial entry
   - Should start with a timestamp and initial note
   - Explain append-only format for future sessions

3. **Verify `plans/PRD.json`**: Ensure it has proper structure
   - Each item needs: id, category, priority_hint, description, steps, passes, notes
   - Don't modify existing PRD items (user defines these)
   - Add a template example if file is empty

4. **Update `scripts/verify.sh`**: Configure for this specific project
   - Detect project type (Node.js, Python, etc.)
   - Add appropriate test/typecheck/lint commands
   - Make it executable

5. **Make initial git commit**: Commit the harness setup
   - Include init.sh, verify.sh updates
   - Include any other harness infrastructure changes
   - Message: "chore: initialize Ralph agent harness"

## Constraints

- Keep everything simple and predictable
- Don't over-engineer or add unnecessary complexity
- Don't modify the core PRD items (user's domain)
- Test that init.sh and verify.sh actually work before committing

## Deliverable

At the end, print:
- ✅ What you changed and why
- 🚀 How to run the Ralph loop (`./scripts/ralph.sh`)
- 📝 Reminder to populate PRD.json with real feature requirements

---

*Based on Anthropic's agent initialization patterns and Geoffrey Huntley's Ralph methodology.*
