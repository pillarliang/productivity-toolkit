# Style — single source of truth

This file is the **only place** to change colors and fonts for every diagram. Edit the values below and Claude will apply them next time you generate.

The skill reads this file **before** opening any template. The values in `templates/*.html` are written for the default skin; if `style.md` differs, Claude substitutes the values during render.

---

## How to use

1. **Default skin works out of the box.** Skip this file entirely if you like the warm parchment + ink-blue look.
2. **Want a different palette?** Edit the **Active tokens** table below — change hex values in the right column. Don't add or rename rows.
3. **Want fonts to match a brand?** Edit the **Active typography** table. The `serif` / `mono` stacks are CSS-style font fallback chains.
4. **Want multiple skins?** Copy this file to `references/style-<name>.md` and tell the skill `"use style-<name>.md for this run"`. Otherwise the skill always reads `style.md`.

The skill won't validate your hex values for contrast — it's your responsibility to keep `ink` readable on `paper` (target WCAG AA 4.5:1).

---

## Active tokens

The 12 semantic roles every template uses. Hex values here override anything in the templates.

| Role | Purpose | Value |
|---|---|---|
| `paper` | Page background, default node fill mask | `#f5f4ed` |
| `ivory` | Slightly cooler paper for secondary surfaces | `#faf9f5` |
| `near-black` | Primary text, strongest stroke | `#141413` |
| `olive` | Secondary text, default arrow stroke, store-node stroke | `#504e49` |
| `stone` | Tertiary text, mono labels, external-node stroke | `#6b6a64` |
| `light-stone` | Series 4 in charts, fade fills | `#b8b7b0` |
| `mist` | Series 5 in charts, deepest neutral fill | `#d4d3cd` |
| `border` | Hairline rule between sections | `#e8e6dc` |
| `brand` | **Focal stroke (1–2 elements per diagram)** | `#1B365D` |
| `brand-tint` | Focal fill | `#EEF2F7` |
| `up` | Candlestick up candle, waterfall positive | `#1B365D` |
| `down` | Candlestick down candle, waterfall negative | `#6b6a64` |

> `up` and `down` default to the same hexes as `brand` and `stone` so the focal accent doubles as the bullish color. If you change `brand` to a non-blue, decide whether financial charts should still use blue/stone or follow your new accent.

### Derived rgba (don't edit — these are computed from above)

| Use | Recipe |
|---|---|
| Standard node fill (white) | `#ffffff` |
| Store node fill | `near-black @ 0.05` → `rgba(20,20,19,0.05)` |
| Cloud node fill | `near-black @ 0.03` → `rgba(20,20,19,0.03)` |
| Cloud node stroke | `near-black @ 0.30` → `rgba(20,20,19,0.30)` |
| External node fill | `olive @ 0.08` (or `stone @ 0.08`) |
| Brand wash header (ER aggregate root) | `brand @ 0.10` |
| Dotted background | `near-black @ 0.08` for the dot circles |

If you change `near-black`, regenerate these by hand in the templates the next time you edit them — or accept that they'll stay at the default.

---

## Active typography

| Role | Family stack | Where used |
|---|---|---|
| `serif` | `Charter, Georgia, Palatino, "TsangerJinKai02", "Source Han Serif SC", "Noto Serif CJK SC", "Songti SC", serif` | Page title, node names, body text, captions |
| `sans` | same as `serif` (one family across the diagram) | — |
| `mono` | `"JetBrains Mono", "SF Mono", Consolas, "TsangerJinKai02", "Source Han Serif SC", monospace` | Eyebrows, sublabels, mono tags, axis labels |

### Font sizes (locked — don't customize)

These are part of the design grammar, not the skin. Changing them breaks the visual rhythm.

| Size | Use |
|---|---|
| 7px | Small mono labels (type tags inside nodes) |
| 9px | Sublabels (port, URL, tech detail) |
| 10px | ER field rows |
| 12px | Node names |
| 14px | ER entity names |
| 1.5rem | Diagram block titles |
| 1.9rem | Diagram-internal h1 |
| 2.4rem | Page-level title |

---

## Constraints (the skill checks these)

When reading this file the skill verifies:

- **`brand` is the most saturated color** in the table. If you set `brand` to a near-grey (e.g. `#666`), the focal signal disappears and the skill will warn you.
- **`paper` is not pure white** (`#ffffff`). Pure white turns the design sterile. Use a cream, bone, or warm grey. If you really want pure white, override this file's check with a comment line: `<!-- paper: pure-white intentional -->`.
- **`ink` (near-black) on `paper` ≥ 4.5:1 contrast.** WCAG AA. The skill will warn if the values fail.
- **No second accent.** This system uses one focal color. If you want to add `accent-warning` or `accent-success`, the answer is no — the design deliberately ships a single accent. Use shape, position, or label to differentiate states instead.

---

## Examples

### Switch to a warmer brand (terracotta)

```diff
-| `brand` | Focal stroke | `#1B365D` |
+| `brand` | Focal stroke | `#a64a2e` |
-| `brand-tint` | Focal fill | `#EEF2F7` |
+| `brand-tint` | Focal fill | `#fbeee9` |
```

### Map to your brand palette (sans-serif corporate)

```diff
-| `serif` | … | `Charter, Georgia, …` |
+| `serif` | … | `"Inter", "Helvetica Neue", system-ui, sans-serif` |
-| `mono` | … | `"JetBrains Mono", "SF Mono", …` |
+| `mono` | … | `"IBM Plex Mono", monospace` |
```

You can use a sans for `serif` — the role name is historical. The skill cares about which slot the family fills, not whether it's actually serif.

---

## What this file does NOT control

- **Layout & coordinates** — those live in the templates and follow the 4px grid. Style is color + font only.
- **Diagram type selection** — that's `diagrams.md`.
- **Page wrapper structure** — `page-shell.html` (it does pick up the colors from this file when Claude renders).
