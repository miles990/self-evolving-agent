# Basic Usage Examples

## Example 1: Performance Optimization

```
User: /evolve Optimize UserList component, target: first render < 100ms

Agent:
📋 Goal Analysis Complete

Goal: UserList first render < 100ms
Current: Need to measure baseline first

Sub-goals:
1. ⏳ Measure current performance baseline
2. ⏳ Identify performance bottlenecks
3. ⏳ Implement optimizations
4. ⏳ Verify performance improvement

Starting execution...

---
🔄 Executing sub-goal 1: Measure baseline

Plan: Use React DevTools Profiler
Do: [Measuring...]
Check: Current first render: 450ms
Act: Record baseline, proceed to next step

---
🔄 Executing sub-goal 2: Identify bottlenecks

Findings:
1. Rendering 1000 UserCards without virtualization
2. Each UserCard recalculates avatar URL
3. useEffect triggers multiple re-renders

Optimization plan:
1. Add react-window virtualization
2. useMemo for avatar URL caching
3. Consolidate useEffect dependencies

Continuing...
```

## Example 2: Learning New Technology

```
User: /evolve Build a ComfyUI workflow for batch game asset generation

Agent:
📋 Goal Analysis Complete

Goal: Batch game asset generation system
Acceptance criteria:
- Generate 10+ images at once
- Consistent style
- Transparent background (PNG)
- 512x512 resolution

---
🔍 Capability Assessment

confident_in:
  - Python programming (proficient)
  - Image processing basics (basic)

uncertain_about:
  - ComfyUI workflows (never used)

definitely_need:
  - ComfyUI node operations
  - Batch processing in ComfyUI

action_plan:
  - Search for ComfyUI skills
  - Install and verify learning
  - Apply to main task

---
📚 Skill Acquisition

Searching: recommend_skill({ query: "ComfyUI game assets" })
→ Found: comfyui-expert (⭐4.9, 2.1k downloads)

Installing: install_skill({ source: "comfyui-expert" })
→ Success

Loading: load_skill({ id: "comfyui-expert" })
→ Learning instructions...

Verifying: Generate a simple 256x256 test image
→ ✅ Success! Skill acquired.

---
Continuing with main task...
```

## Example 3: Goal Clarification

```
User: /evolve Optimize performance

Agent:
❓ Need to clarify goal details

Your goal: "Optimize performance"

Please help me confirm:

1. Success criteria
   □ Just needs to work
   □ Specific performance target (please specify)
   □ Must pass tests/acceptance criteria

2. Scope
   □ Core functionality only
   □ Complete implementation (including edge cases)
   □ Need to consider extensibility

3. Quality vs Speed
   □ Quick completion preferred
   □ Quality first
   □ Balanced

What would you like to focus on?
```

## Example 4: Multi-Strategy Recovery

```
User: /evolve Generate transparent background game icons

Agent:
🔄 Attempt #1: Default generation
Result: ❌ Failed - White background in output

📝 Diagnosis: Knowledge Gap
→ Need to learn transparent background techniques

🔍 Searching solutions...
Found: Use RemBG node for background removal

---
🔄 Attempt #2: Add RemBG node
Result: ❌ Failed - RemBG not installed

📝 Diagnosis: Environment Issue
→ Missing required node

🔧 Installing ComfyUI-Manager → Installing RemBG node

---
🔄 Attempt #3: RemBG with proper setup
Result: ✅ Success - Transparent PNG output

💾 Saving experience to memory:
- Context: Game asset generation, transparent background
- Problem: Default output has white background
- Solution: Use RemBG node for post-processing
- Verified: ✅ Success
```

## Tips for Best Results

1. **Be Specific** - Include measurable success criteria
2. **Set Constraints** - Mention any limitations or requirements
3. **Provide Context** - What problem are you solving?

```
❌ Bad: /evolve Make it faster

✅ Good: /evolve Optimize the UserList component
         Target: First render under 100ms
         Constraint: Don't change the API interface
         Test: Use React DevTools Profiler
```
