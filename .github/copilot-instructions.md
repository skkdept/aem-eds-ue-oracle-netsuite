# EDS Conversion — Constitution

This file is the **ASDD Constitution** for this repository. All agents (Copilot, Claude Code, or any AI assistant) must follow these rules in every session — no exceptions. Rules here take precedence over any agent-specific instructions when there is a conflict.

Think of this as the building code. Individual agent files are the blueprints. Blueprints cannot override the building code.

---

## ASDD Governance Layers

| Layer | File(s) | Role |
|-------|---------|------|
| **Constitution** | `copilot-instructions.md` ← you are here | Non-negotiable law for all agents |
| **Skills** | `.github/skills/eds-conversion/SKILL.md` | Domain expertise and templates |
| **Agents** | `.github/agents/*.agent.md` | Step-specific execution workers |
| **Spec** | `downloads/*/CONVERSION_PLAN.md` | Per-project blueprint (plan before code) |

---

## Law 1 — Default Content Before Blocks (David's Model)

For every content sequence on a page, ask this question first:

> **"Can an author create this by just typing in Word/Docs?"**

| Answer | Action |
|--------|--------|
| Yes | Mark as **default content** — no block needed |
| No | Select the appropriate block type |

**Default content includes:** headings, paragraphs, images, links, simple lists.

**Never create a block for content that can be typed.**

---

## Law 2 — Block Content Model Rules

When a block is required, apply the correct canonical model:

| Model | Use When | Rule |
|-------|----------|------|
| **Standalone** | Unique one-off element | Safe default. Flexible structure. |
| **Collection** | Repeating items | Each row = one item. Columns = parts of that item. |
| **Configuration** | API-driven behavior only | Key/value pairs. NEVER for static content. |
| **Auto-Blocked** | Predictable pattern JS can detect | Rare. Tabs from H2 sections, YouTube from URLs. |

**Hard limits — no exceptions:**
- Maximum **4 cells per row**
- Use block **variants** for styling: `| Hero (Dark) |` — never a config cell
- Configuration model is for behavior (API calls, filters, sort) — NOT for static content display

---

## Law 3 — Block Collection First

Before writing any new block from scratch:

1. Check `.github/skills/eds-conversion/block-collection/index.json`
2. If the block exists → **copy from cache, customize CSS only**
3. If the cache is missing → note it and build from scratch; remind user to run `python3 scripts/fetch-block-collection.py` once

Never rebuild a block that already exists in Block Collection.

---

## Law 4 — Pre-Decoration DOM

The JS decorator receives the **pre-decoration DOM** (raw divs from the block table). Always:

- Re-use existing elements — query `h2`, `img`, `p`, `a` with semantic selectors
- Never create new wrapper elements around existing content
- Never assume a fixed cell index — `block.children[0].children[1]` is fragile; `block.querySelector('img')` is not

---

## Law 5 — CSS Rules

- **No `!important`** — ever
- **No hardcoded color/size values** — use CSS custom properties (`--block-name-*`)
- **Mobile-first** — write base styles for mobile, scale up with `min-width` media queries
- **EDS breakpoints**: mobile `< 600px`, tablet `600–900px`, desktop `> 900px`
- **Scoped styles** — prefix all selectors with the block class: `.block-name h2 { ... }`

---

## Law 6 — Quality Gates (Non-Negotiable)

No block is complete until all three pass:

1. **`npm run lint`** — must pass with zero errors
2. **Screenshots at 3 viewports** — mobile, tablet, desktop — captured and compared to source
3. **No console errors** — open browser devtools, confirm clean console

Claiming "it looks right" without screenshots is a quality gate failure.

---

## Law 7 — Content Generation

- Import **ALL content** from the source page — no truncation, no placeholders, no "..." summaries
- Section breaks are `<hr>` elements
- Images go in `eds-html/assets/images/` with relative paths
- `eds-html/` is in `.gitignore` and is never committed

---

## Law 8 — Unknown EDS Patterns

When uncertain about any EDS behavior (section-metadata, query-index, auto-blocking, sidekick, block variants syntax):

→ Use `aem-edge-delivery-services:docs-search` to look it up

Do not guess. Do not invent undocumented behavior.

---

## Law 9 — What Gets Committed

```bash
# Commit ONLY component code
git add blocks/ scripts/ models/ styles/

# NEVER commit
# downloads/    ← source website assets
# eds-html/     ← generated content HTML
```

---

## Workflow Overview

```
Step 1: Download     → downloads/{site}/  (wget mirror)
Step 2: Analyze      → CONVERSION_PLAN.md (David's Model + Block Collection + canonical models)
Step 3: Build        → blocks/{name}/     (REUSE cache or BUILD; lint + screenshots required)
Step 4: Generate     → eds-html/          (all content; never truncate)
```

Invoke the orchestrator: `/eds-converter` or use the sample prompt in `eds-converter-main.agent.md`.

---

## Prerequisites

- Repository cloned from `adobe/aem-boilerplate`
- GitHub app **AEM Code Sync** installed
- Block Collection cache populated: `python3 scripts/fetch-block-collection.py` (run once)
- `downloads/` and `eds-html/` in `.gitignore`
