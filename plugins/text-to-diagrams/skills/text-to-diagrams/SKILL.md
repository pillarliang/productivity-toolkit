---
name: text-to-diagrams
description: Given a text, analyze its content and generate one or more kami-style diagrams (HTML + inline SVG) into a single HTML page plus per-figure SVG files. Triggers on "把这段文字画成图 / 给这段话配图 / 文本转图表 / 帮我把这段内容做成图 / make diagrams from this text / visualize this".
---

# text-to-diagrams

Given a text, pick the right diagram(s) from a fixed catalog of 17 types and emit one HTML page with all of them embedded — plus a standalone `.svg` for each figure so the user can drop individual diagrams into other docs.

Inherited skin from [kami](https://github.com/tw93/kami) — warm parchment + ink-blue accent + serif hierarchy. Engineering trio (sequence / ER / pyramid) ported from [diagram-design](https://github.com/cathrynlavery/diagram-design). Edit [`references/style.md`](references/style.md) to retheme everything.

## When to use

- User pastes raw text and asks for a diagram or "visualize this".
- A document needs supporting figures and you want to extract them in one pass.
- You need multiple diagrams from one source of truth (architecture + flow + breakdown all at once) — anywhere from 1 to a dozen or more, depending on how much structure the source has.

When **not** to use:

- User wants a single specific diagram and supplies the data → use kami's diagram skill directly.
- User wants prose, not structure → don't draw.
- User wants slides or a long-doc → use `kami`. This skill is for diagrams only.

## Step 0 · Read the style file

**Always read [`references/style.md`](references/style.md) first.** It is the user-editable source of truth for colors and fonts. The hex values inside template files are defaults — if `style.md` differs, substitute the new values when you write the SVG.

What to extract from `style.md`:

- All 12 token values from the **Active tokens** table (`paper`, `near-black`, `olive`, `stone`, `brand`, `brand-tint`, `up`, `down`, etc.)
- The two font stacks (`serif`, `mono`) from **Active typography**

If the user explicitly says `"use style-<name>.md for this run"`, read that file instead.

## Step 1 · Decide if there should be diagrams at all

> Would a well-written paragraph teach the reader less than this diagram?

If "no", tell the user the text doesn't have structure that a diagram can add to. Don't draw.

## Step 2 · Read the catalog

Always read [`references/diagrams.md`](references/diagrams.md) before choosing — it has the full selection table, color tokens, type-specific conventions (sequence § 7, ER § 7, pyramid § 7), and anti-pattern list. Don't pick from memory.

| Showing… | Type |
|---|---|
| System components + connections | Architecture |
| Decision branches | Flowchart |
| Time-ordered messages between actors | Sequence |
| Database tables + relationships | ER / data model |
| Two-axis positioning | Quadrant |
| Ranked hierarchy / funnel | Pyramid |
| Category comparison | Bar chart |
| Trend over time | Line chart |
| Proportional breakdown | Donut |
| Finite states + transitions | State machine |
| Time axis + milestones | Timeline |
| Cross-role process | Swimlane |
| Hierarchy | Tree |
| Stacked layers | Layer stack |
| Set intersections | Venn |
| OHLC price | Candlestick |
| Value decomposition | Waterfall |

## Step 3 · Plan the diagrams

1. Read the **whole** text first.
2. List every claim with structure (hierarchy, magnitude, direction, order, intersection, decomposition).
3. Group claims that belong to the same diagram.
4. For each group, pick the type whose "when to use" matches the dominant relationship.
5. Drop groups a paragraph would teach better.
6. **Let the source decide the count — no fixed cap.** A short note may yield 1 diagram; a long paper, design spec, or technical doc may need 10+. Each diagram must independently pass Step 1: would a paragraph teach the reader less than this diagram? Drop any that fail. The original concern — too many diagrams making the page read as a template — is real but is fixed by structure, not by capping count. When the count exceeds ~6, group diagrams under section headings on the page (see Step 5) so the reader scans a structured document instead of scroll-reading a dump.
7. Write down the plan: page title, optional section headings (when grouping), then per diagram (type, title, content to draw, focal element, optional caption).

## Step 4 · Render each diagram

For each entry in the plan:

1. Open the matching template under `templates/<type>.html`.
2. Extract the `<svg>...</svg>` block. Keep the same `viewBox`.
3. Edit `<text>` and `<rect>` values to match the spec.
4. **Apply style.md values** — every hex and font reference inside the SVG should use the token values you read in Step 0, not the template defaults (when they differ).
5. Apply the editing rules in `references/diagrams.md` § 4 — coordinates divisible by 4, max 3 width tiers, font sizes 7/9/12, arrow endpoints on node edges exactly.
6. Apply the focal rule: 1–2 elements wear `brand-tint` fill + `brand` stroke, everything else neutral. The focal must match what the caption emphasizes.

## Step 5 · Assemble & write outputs

You produce **two kinds of files**:

### A. Combined page

Copy [`references/page-shell.html`](references/page-shell.html) and fill it in:

- Replace `{{PAGE_TITLE}}` with the overall title.
- Replace `{{RATIONALE}}` with one italic paragraph explaining why these diagrams.
- Replace `{{N}}` with the diagram count.
- For each diagram: duplicate the `<section class="diagram-block">` block. Set the eyebrow to `Figure N · TypeName` (e.g. `Figure 2 · Donut chart`), the title, paste the `<svg>…</svg>` block from Step 4, and the italic caption.
- **Long pages (>6 diagrams): group with section headings.** Insert `<h2 class="section-title">Section name</h2>` between groups of `diagram-block`s so the page reads as a chaptered document, not a flat list. Group by the source's natural sections (e.g. "Architecture", "Data model", "Operational flow"). Single-section short pages can skip this.
- **Apply style.md values** to the page-shell `<style>` block too.
- Leave the colophon as is, or swap for the user's own attribution.

Default filename: `output.html` (or whatever the user specified).

### B. Per-figure SVG files

For each diagram, also write a standalone `.svg` file containing **just** the `<svg>…</svg>` block (no HTML wrapper). These are for the user to drop into other documents (slides, blog posts, Figma).

Default location: `output/figure-<N>-<type>.svg` next to the combined HTML.

Example:

```text
output.html
output/figure-1-architecture.svg
output/figure-2-donut-chart.svg
output/figure-3-line-chart.svg
```

If the user said "skip individual SVGs" or specified a single output path with no folder, omit the per-figure files.

## Step 6 · Optional: convert SVGs to PNG

The skill ships with [`tools/svg-to-png.sh`](tools/svg-to-png.sh) which wraps `rsvg-convert` (preferred) or headless Chromium. Only invoke it if the user explicitly asks for PNG.

```bash
bash tools/svg-to-png.sh output/figure-1-architecture.svg
# writes output/figure-1-architecture.png

bash tools/svg-to-png.sh output/   # batch convert every SVG in the folder
```

Tell the user the output path. Don't try to embed PNG into the page — the page already has inline SVG.

## Step 7 · Sanity check before delivering

- [ ] Each diagram has exactly 1–2 focal elements
- [ ] No focal color contradicts a caption
- [ ] Arrow endpoints land on node edges (not floating)
- [ ] All coordinates divisible by 4
- [ ] No `box-shadow`, no gradient, no `border-radius` > 10px
- [ ] No emoji or decorative icons
- [ ] Style values from `style.md` applied wherever they differ from template defaults
- [ ] Per-figure `.svg` files written (unless user opted out)

## Anti-patterns

See `references/diagrams.md` § 5 — the full table. The big ones:

- Dark mode + cyan glow (cheap "technical" signifier)
- All nodes identical size (no hierarchy)
- 5+ focal-color nodes (focal rule broken)
- Arrow labels without a masking rect
- Per-node custom widths within one diagram
- Focal color contradicts the caption's emphasis
- Adding a second accent color (warning amber, success green) — this system is single-accent by design
