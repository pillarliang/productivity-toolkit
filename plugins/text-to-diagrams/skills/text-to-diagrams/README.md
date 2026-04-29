# text-to-diagrams

> Given a text, pick the right diagrams from a fixed catalog of 17 types and emit one HTML page with all of them embedded — plus a standalone SVG for each figure.

A Claude Code skill with a warm-parchment + ink-blue + serif skin, focused on one job: **text in, diagrams out**.

## What it does

1. **Read style** — Load color and font tokens from `[references/style.md](references/style.md)` (user-editable).
2. **Analyze** — Read the text, detect whether the source is markdown or plain text, then decide which diagrams best illustrate the structural claims — let the source's structure dictate the count (1 for a short note, 10+ for a long paper or design spec). Pick from 17 types. For markdown sources, also pick an **anchor** for each figure so it can be inserted at the right spot.
3. **Render** — For each, fill the matching template into an `<svg>` block, applying the style tokens.
4. **Assemble** — Stitch the SVGs into one HTML page with a title, rationale, and per-diagram captions.
5. **Export** — Always write three artifacts: the combined HTML page, a per-figure `.svg` for each diagram, and an `output.md` file. For markdown sources `output.md` is the original prose verbatim with figure references inserted at the planned anchors; for plain-text sources it's a synthesized markdown stack mirroring the HTML page. Optional shell helper converts SVGs to PNG.

## The 17 diagram types

| Type            | When                                                       |
| --------------- | ---------------------------------------------------------- |
| Architecture    | System components + connections                            |
| Flowchart       | Decision branches                                          |
| Sequence        | Time-ordered messages between actors (API call, RPC chain) |
| ER / data model | Database tables, entities, foreign keys                    |
| Quadrant        | Two-axis positioning                                       |
| Pyramid         | Ranked hierarchy / value pyramid / conversion funnel       |
| Bar chart       | Category comparison                                        |
| Line chart      | Trend over time                                            |
| Donut chart     | Proportional breakdown                                     |
| State machine   | Finite states + transitions                                |
| Timeline        | Time axis + milestones                                     |
| Swimlane        | Cross-role process                                         |
| Tree            | Hierarchy                                                  |
| Layer stack     | Stacked layers (OSI etc.)                                  |
| Venn            | Set intersections                                          |
| Candlestick     | OHLC price action                                          |
| Waterfall       | Value decomposition                                        |

Full selection logic, color tokens, type-specific conventions, and anti-patterns in `[references/diagrams.md](references/diagrams.md)`.

## Install

Symlink (recommended — edits to the project become live in next session):

```bash
ln -s /path/to/text-to-diagrams ~/.claude/skills/text-to-diagrams
```

Or copy:

```bash
cp -r /path/to/text-to-diagrams ~/.claude/skills/
```

Verify by opening a new Claude Code session and looking for `text-to-diagrams` in the available skills list.

## Use

Trigger phrases (Chinese / English):

| You say | What Claude does |
| --- | --- |
| 把这段文字画成图 + 文本 | Read whole text → detect markdown vs plain text → pick the right diagrams (count driven by source) → fill templates → assemble HTML + per-figure SVG + markdown |
| 给这段话配图 | Same |
| 文本转图表 | Same |
| visualize this: + text | Same |
| make diagrams from this text | Same |

Or invoke directly: `/text-to-diagrams` followed by the text.

To save the result to disk, add `"写到 output.html"` / `"save to output.html"` to your prompt. Three artifacts land next to each other:

- `output.html` — combined page with inline SVGs.
- `output.md` — for markdown sources, the original prose verbatim with `![](output/figure-N-*.svg)` references inserted at planned anchors; for plain-text sources, a synthesized markdown stack. Drop straight into Obsidian, GitHub, MkDocs, etc.
- `output/figure-N-<type>.svg` — one standalone SVG per figure, referenced by both of the above.

To skip per-figure SVGs (and the markdown file, which would have nothing to reference): `"only the page, no individual SVGs"`.

## Customizing the look

`[references/style.md](references/style.md)` is the **single source of truth** for colors and fonts. Edit hex values in its **Active tokens** table and Claude applies them on the next render — no code changes, no template editing.

Two quick recipes inside `style.md`:

- Switch accent from ink-blue to terracotta
- Map onto a sans-serif corporate brand

The skill checks contrast (WCAG AA), refuses pure-white paper, and rejects a second accent — all driven by a file edit, no code changes needed.

For multiple skins, copy `style.md` to `references/style-<name>.md` and tell the skill `"use style-<name>.md for this run"`.

## Converting SVG → PNG

The skill writes inline-SVG HTML by default. PNG is opt-in via `[tools/svg-to-png.sh](tools/svg-to-png.sh)`:

```bash
# Single file
bash tools/svg-to-png.sh output/figure-1-architecture.svg

# Batch — every *.svg in a directory
bash tools/svg-to-png.sh output/

# Custom width or background
PNG_WIDTH=3000 PNG_BG='#f5f4ed' bash tools/svg-to-png.sh output/figure-1-architecture.svg
```

Picks the first available converter:

1. `rsvg-convert` (`brew install librsvg`) — fastest, sharpest text
2. Headless Chromium / Google Chrome — fallback

Defaults: 2000px wide, transparent background. Set `PNG_BG='#f5f4ed'` to bake in the parchment background.

## Project layout

```text
text-to-diagrams/
├── SKILL.md                  # the skill instructions Claude follows
├── README.md
├── templates/                # 17 self-contained HTML+SVG diagrams
├── references/
│   ├── style.md              # editable color + font tokens (single source of truth)
│   ├── diagrams.md           # selection table, type conventions, anti-patterns
│   └── page-shell.html       # multi-diagram page wrapper
├── tools/
│   └── svg-to-png.sh         # optional SVG→PNG converter (rsvg / chromium)
└── examples/                 # sample inputs
```

## Design constraints

Global rules:

- **Coordinates divisible by 4** — anti-AI-slop floor.
- **Focal rule** — at most 2 elements wear the brand-tint + brand-stroke. Everything else neutral.
- **Content drives diagram count** — no fixed cap. A short note: 1 diagram. A long technical paper or design spec: 10+. Mitigate template-feel on long pages by grouping diagrams under section headings, not by capping count.
- **One accent color** — no warning amber, no success green. Use shape, position, or label to differentiate states.

Type-specific:

- **Sequence**: time runs top→down only; activation bars on lifelines; one focal actor.
- **ER**: aggregate root wears the accent; join tables get a dashed border.
- **Pyramid**: widths are honest (proportional to count); accent on the apex, never the base.

## License

MIT. Templates and design language adapted from [kami](https://github.com/tw93/kami) (MIT) and [diagram-design](https://github.com/cathrynlavery/diagram-design) (MIT).
