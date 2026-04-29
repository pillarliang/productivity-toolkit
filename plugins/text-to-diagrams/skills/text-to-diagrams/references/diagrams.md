# Diagram catalog

17 diagram types. Each is a self-contained HTML + inline SVG, embeddable in any
document. All wear the same skin defined in [`style.md`](style.md) — warm
parchment canvas (`#f5f4ed`), ink-blue focal accent (`#1B365D`), neutral warm
grays. Edit `style.md` to retheme every template at once.

---

## 1. Selection table

Use this table when deciding which diagram a piece of content needs.

| Showing… | Use | Template |
|---|---|---|
| System components + connections | **Architecture** | `templates/architecture.html` |
| Decision branches, "if A then B else C" | **Flowchart** | `templates/flowchart.html` |
| Time-ordered messages between actors (API call, RPC chain) | **Sequence** | `templates/sequence.html` |
| Database tables, entities, foreign keys | **ER / data model** | `templates/er.html` |
| Two-axis positioning / prioritization | **Quadrant** | `templates/quadrant.html` |
| Ranked hierarchy / value pyramid / conversion funnel | **Pyramid** | `templates/pyramid.html` |
| Category comparison (revenue, market share, quarterly) | **Bar chart** | `templates/bar-chart.html` |
| Trend over time (stock price, growth rate, time series) | **Line chart** | `templates/line-chart.html` |
| Proportional breakdown (spend, user segments, share) | **Donut chart** | `templates/donut-chart.html` |
| Finite states + directed transitions (lifecycle, state machine) | **State machine** | `templates/state-machine.html` |
| Time axis + milestone events (roadmap, project progress) | **Timeline** | `templates/timeline.html` |
| Cross-responsibility process (multi-role, API request path) | **Swimlane** | `templates/swimlane.html` |
| Hierarchical relationships (org chart, module deps, directory tree) | **Tree** | `templates/tree.html` |
| Vertically stacked system layers (OSI, application stack) | **Layer stack** | `templates/layer-stack.html` |
| Set intersections (feature overlap, audience comparison) | **Venn** | `templates/venn.html` |
| OHLC price action (stock price, trading days, up/down candles) | **Candlestick** | `templates/candlestick.html` |
| Revenue bridge, valuation decomposition, cash flow breakdown | **Waterfall** | `templates/waterfall.html` |

Not on the list:
- **Compare two things**: use a table. A three-column table beats any diagram of a binary contrast.
- **One box with a label**: delete the box, write the sentence.

### The question before drawing

> Would a well-written paragraph teach the reader less than this diagram?

If "no", don't draw. Diagrams add signal to hierarchy, direction, and magnitude.
They don't decorate prose.

---

## 2. Multi-diagram from one text

A single text often calls for multiple diagrams. The split rules:

- **One diagram per concept.** If the text covers architecture, then a process,
  then revenue numbers, that's three diagrams.
- **No fixed cap on diagram count — let the source dictate.** A short note may
  yield 1 diagram; a long paper, RFC, or design spec may yield a dozen or more.
  The old "max 4" rule is replaced because long-form content (academic papers,
  technical specs, multi-system designs) genuinely needs more figures, and
  arbitrarily capping them either drops information or splits one document into
  artificial halves.
- **Mitigate template-feel by structure, not by count.** The original worry —
  that lots of diagrams make the page read as a template, not a document — is
  fixed by **grouping diagrams under section headings** when the count exceeds
  ~6 (see SKILL.md Step 5). Group by the source's natural sections.
- **Each diagram still has to earn its place.** The "would a paragraph teach
  less than this diagram?" question (§ 1) is applied to every figure
  individually, no matter how many you have. Padding a long page with weak
  diagrams is worse than capping the count.
- **Skip duplicates.** Two flowcharts that show the same decision from
  different angles is one flowchart with the better framing.

When extracting diagrams from a text:

1. Read the whole text first; do not pick diagrams paragraph-by-paragraph.
2. List every claim that has structure (hierarchy, magnitude, direction, order).
3. Group claims that belong to the same diagram.
4. For each group, pick the diagram type that fits the dominant relationship.
5. Drop groups that a paragraph would teach better.
6. If you end up with more than ~6 diagrams, plan section groupings: cluster
   figures by the source's natural sections so the page can be chaptered.

---

## 3. Complexity budget per diagram

Aim for what the content needs — no upper bound on node count. A
seventeen-node architecture is fine if all seventeen nodes carry weight. The
real constraints are about **clarity**, not count:

- Two nodes that always travel together → they're one node
- A line whose meaning is obvious from layout → remove the line
- 5 nodes in ink-blue → you haven't decided what's focal

**Focal rule**: 1–2 focal elements per diagram (`#1B365D` stroke + `#EEF2F7`
fill). Everything else goes neutral. Focal signal comes from contrast, not count.

---

## 4. Editing rules (when filling a template)

Each template ships with placeholder text and example coordinates. To adapt one:

- **All coordinates, widths, and gaps must be divisible by 4.** This is the
  anti-AI-slop floor. Break it once and the diagram starts looking "close
  enough".
- Node widths: 128 / 144 / 160 (three tiers, don't add more).
- Node heights: 32 (pill) / 64 (standard).
- Font sizes: 7 (small mono label) / 9 (sublabel mono) / 12 (name sans).
- **Arrow endpoints land exactly on node edges.** A 10px gap is visible to the eye.
- **SVG top padding**: `<text y="…">` y is the baseline. Cap letters extend
  above by font-size × 1.2 — pad the viewBox or move y down.
- **Chevron arrows, not filled triangles** for editorial feel.

### Color token map

| SVG role | Token name | Value |
|---|---|---|
| Canvas | parchment | `#f5f4ed` |
| Standard node fill | white | `#ffffff` |
| Standard node stroke | near-black | `#141413` |
| Store node fill | near-black 5% | `rgba(20,20,19,0.05)` |
| Store node stroke | olive | `#504e49` |
| Cloud node fill | near-black 3% | `rgba(20,20,19,0.03)` |
| Cloud node stroke | near-black 30% | `rgba(20,20,19,0.30)` |
| External node fill | olive 8% | `rgba(94,93,89,0.08)` |
| External node stroke | stone | `#6b6a64` |
| **Focal fill** | brand-tint | `#EEF2F7` |
| **Focal stroke** | brand | `#1B365D` |
| Standard arrow | olive | `#504e49` |
| Focal arrow | brand | `#1B365D` |
| Primary text | near-black | `#141413` |
| Secondary text | olive | `#504e49` |
| Tertiary text / mono label | stone | `#6b6a64` |

Don't add a fourth state ("warning amber", "success green"). One accent only.

---

## 5. Anti-patterns

Scan for these when drawing or reviewing:

| Anti-pattern | Why it fails |
|---|---|
| Dark mode + cyan / purple glow | Cheap "technical" signifier with no design decision |
| All nodes identical size | Destroys hierarchy |
| Legend floating inside the diagram area | Collides with nodes |
| Arrow labels without a masking rect | Line bleeds through the text |
| Vertical writing-mode text on arrows | Unreadable |
| `box-shadow` on anything | One-accent design forbids it |
| `border-radius` above 10px | Max 6–10px. Beyond, App Store chrome. |
| Ink Blue on every "important" node | Focal rule is 1–2, not a signaling system |
| Decorative icons | Disaster |
| Gradient backgrounds | Forbidden |
| Focal color contradicts the caption | Caption says X is core but Y is painted ink-blue |
| 5–10px gap between arrow endpoint and node edge | Reads as floating |
| Per-node custom widths within one diagram | Widths 60 / 76 / 80 / 100 feel hand-patched |

---

## 6. Data chart formulas

### Bar / line chart Y-axis (default scale: max=140, chart-height=280, scale=2)
```
bar_height = value × 2
bar_top_y  = 320 - bar_height   (baseline y = 320)
dot_y      = 320 - value × 2
```

### Donut chart arcs (cx=300 cy=200 R=136 r=76, clockwise from -90°)
```
angle_start = -90 + sum_of_previous_percentages × 3.6
angle_end   = angle_start + this_percentage × 3.6
outer_x = 300 + 136 × cos(angle_deg × π/180)
outer_y = 200 + 136 × sin(angle_deg × π/180)
```
`large-arc=1` only when segment > 180°.

### Candlestick Y-axis (default: price 100–160, chart-height=280, scale=4.67)
```
candle_y = 320 - (price - 100) × 4.67
Up candle (close > open):    fill #1B365D
Down candle (close < open):  fill #6b6a64
Wick: 1.2px stroke from high_y to low_y, centered on candle
```

### Waterfall (default: max=200, chart-height=280, scale=1.4)
```
bar_y = 320 - value × 1.4
Floating bars: top = running_total_y, height = abs(delta) × 1.4
Positive: #1B365D · Negative: #6b6a64 · Total: #4d4c48
Connector: dashed 0.8px #b8b7b0 between adjacent bar edges
```

### Series styling

No hard cap on categories or series. The signal limit comes from one focal
series in ink-blue (`#1B365D`); everything else cycles through the neutral
warm palette (olive → stone → light-stone → mist → brand-tint). When a chart
has more series than the palette has neutrals, repeat the palette and rely on
position labels to disambiguate.

---

## 7. Type-specific conventions (sequence / ER / pyramid)

These three types have stricter conventions than the rest of the catalog —
they encode time, data shape, and rank, so layout choices carry meaning.

### Sequence

- **Lifeline x-coords stay fixed**; messages move down the y-axis. Default actor
  centers in the template are 128 / 352 / 584 / 800.
- **Activation bars** (w=8 rect) on a lifeline mark when that actor holds
  control. Draw them before message arrows so arrows land on their edges.
- **Time runs top→down only.** No upward messages — if the system actually does
  call back, draw a return arrow from the receiver's lifeline back to the
  sender, lower on the y-axis.
- **Self-message**: small U-loop on the same lifeline, 32–40px wide, label to
  the right of the loop.
- **Message labels**: every arrow needs an opaque parchment mask behind its
  label so the line doesn't bleed through.
- **Arrow types**: standard olive `#504e49` for normal messages; ink-blue
  `#1B365D` for the focal / primary response; dashed olive for return values
  and async / fire-and-forget.

### ER / data model

- **Entity box header** = name in serif sans + type tag (`ENTITY` / `JOIN` /
  `AGGREGATE ROOT`) in mono above. Header band gets a tinted fill (4–6%
  opacity of stroke color); body fills white (or brand-tint for the focal
  entity).
- **Aggregate root** wears the ink-blue accent. Don't accent more than one
  entity per diagram — if two feel equally focal, the diagram is showing two
  things and should split.
- **Join tables** get a dashed border and a `JOIN` tag instead of `ENTITY`,
  signaling they exist only to carry foreign keys.
- **Field rows** are mono, two columns: name (left, near-black) + type (right,
  olive, right-aligned). Primary keys prefixed with `#`, foreign keys with `→`.
- **Cardinality labels** (`1`, `N`, `0..1`, etc.) sit on the relationship line,
  each behind its own tiny parchment mask, near the entity it describes.

### Pyramid / Funnel

- **Pick one orientation and hold it.** Pyramid (point up) = apex is rarest /
  most valuable. Funnel (point down) = narrow end is conversion. Don't mix.
- **4–6 layers** as trapezoids built from `<polygon points="…"/>` with 4
  vertices each. Consistent layer height (default 64).
- **Widths shrink linearly** from base to apex (or reverse for funnel). When
  showing real funnel data, widths must be honest (proportional to count
  / percentage). Equal widths are a layer cake, not a pyramid.
- **One layer wears the accent** — apex of pyramid, conversion layer of
  funnel, or critical bottleneck. Never the base (dilutes the "apex = rare"
  signal).
- **Side annotations** (count, percentage, drop-off) go just outside the
  trapezoid edge, mono, stone color.
- **Optional left-margin axis** with a vertical mono label like
  `RARER · FEWER · COMPOUNDS ↑` reinforces the direction.

---

## 8. Template structure

Every template has this skeleton:

```html
<!DOCTYPE html>
<html><head>
  <style>/* palette tokens, body styling, typography */</style>
</head><body>
  <div class="frame">
    <p class="eyebrow">Diagram type · label</p>
    <h1>{{Title placeholder}}</h1>
    <svg viewBox="…">
      <!-- defs: arrow markers, patterns -->
      <!-- background -->
      <!-- arrows / lines (behind nodes) -->
      <!-- nodes (rects, text) -->
      <!-- legend strip -->
    </svg>
    <p class="caption">{{Caption explaining the focal element}}</p>
  </div>
</body></html>
```

When embedding multiple diagrams in one page, extract only the `<svg>…</svg>`
block plus the surrounding `<div class="frame">`, drop into a parent HTML page
that imports the palette CSS once.
