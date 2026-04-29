# Productivity Toolkit

**Language / 语言**: [English](README.md) | [中文简体](docs/README.zh-cn.md) | [繁體中文](docs/README.zh-tw.md) | [Deutsch](docs/README.de.md) | [Français](docs/README.fr.md) | [Italiano](docs/README.it.md) | [日本語](docs/README.ja.md) | [한국어](docs/README.ko.md) | [Português](docs/README.pt.md) | [Español](docs/README.es.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code Marketplace](https://img.shields.io/badge/Claude%20Code-Marketplace-blue.svg)](https://code.claude.com/docs/en/plugins)

A Claude Code marketplace bundling productivity plugins. One repo, multiple plugins — install only the ones you need.

## What's inside

| Plugin | What it does | Install |
| --- | --- | --- |
| **[python-code-style](plugins/python-code-style/)** | Enforces professional Python style guidelines on code generation and powers structured code reviews. Naming conventions, docstring formats, import order, PEP 8 / Google styleguide rules. | `/plugin install python-code-style@productivity-toolkit` |
| **[text-to-diagrams](plugins/text-to-diagrams/)** | Picks from 17 diagram types (architecture, flowchart, sequence, ER, pyramid, donut, …) and turns raw text into a single HTML page of diagrams plus standalone SVGs. Kami-style. | `/plugin install text-to-diagrams@productivity-toolkit` |

Each plugin is self-contained — its own `plugin.json`, its own `SKILL.md`, its own references and assets. The marketplace just lists them.

## Install

### 1. Add the marketplace

In Claude Code, run once:

```bash
/plugin marketplace add pillarliang/productivity-toolkit
```

### 2. Install the plugins you want

```bash
# Just Python style support
/plugin install python-code-style@productivity-toolkit

# Just diagrams
/plugin install text-to-diagrams@productivity-toolkit

# Both
/plugin install python-code-style@productivity-toolkit
/plugin install text-to-diagrams@productivity-toolkit
```

### Alternative: declare in settings.json

```json
{
  "extraKnownMarketplaces": {
    "productivity-toolkit": {
      "source": {
        "source": "github",
        "repo": "pillarliang/productivity-toolkit"
      }
    }
  },
  "enabledPlugins": {
    "python-code-style@productivity-toolkit": true,
    "text-to-diagrams@productivity-toolkit": true
  }
}
```

### Alternative: install as standalone skills via `npx skills`

If you want the skills (just the `SKILL.md` and its references) without the Claude Code plugin wrapper — useful when sharing with other agents like Cursor — use the [skills](https://skills.sh/) CLI:

```bash
# Both skills, installed globally
npx skills add pillarliang/productivity-toolkit -g

# Just one
npx skills add pillarliang/productivity-toolkit -g --skill python-code-style
npx skills add pillarliang/productivity-toolkit -g --skill text-to-diagrams
```

Drop `-g` to install into the current project instead. Verify with `npx skills ls -g`.

### Alternative: manual

```bash
git clone https://github.com/pillarliang/productivity-toolkit.git
cp -r productivity-toolkit/plugins/python-code-style ~/.claude/plugins/
cp -r productivity-toolkit/plugins/text-to-diagrams ~/.claude/plugins/
```

### Verify

Run `/plugin` or `/plugin list` in Claude Code to confirm the plugins are installed.

## Update

**Manual:**

```bash
/plugin marketplace update pillarliang/productivity-toolkit
```

Or via UI: `/plugin` → **Marketplaces** tab → select the marketplace → **Update**.

**Auto-update:**

1. Run `/plugin`
2. **Marketplaces** tab
3. Select the target marketplace
4. **Enable auto-update**

> Third-party marketplaces have auto-update disabled by default. Enable it once and Claude Code will refresh on startup.

## Uninstall

```bash
/plugin uninstall python-code-style@productivity-toolkit
/plugin uninstall text-to-diagrams@productivity-toolkit

# Or remove the whole marketplace (uninstalls all plugins from it)
/plugin marketplace remove pillarliang/productivity-toolkit
```

## Repo layout

```text
productivity-toolkit/
├── .claude-plugin/
│   └── marketplace.json              # Lists both plugins
├── plugins/
│   ├── python-code-style/
│   │   ├── .claude-plugin/plugin.json
│   │   └── skills/python-code-style/
│   │       ├── SKILL.md
│   │       └── references/           # docstrings, naming, language, style rules
│   └── text-to-diagrams/
│       ├── .claude-plugin/plugin.json
│       └── skills/text-to-diagrams/
│           ├── SKILL.md
│           ├── README.md             # Skill-specific docs
│           ├── templates/            # 17 diagram HTML templates
│           ├── references/           # style.md, diagrams.md, page-shell.html
│           ├── tools/svg-to-png.sh   # Optional SVG→PNG converter
│           └── examples/             # Sample inputs + rendered outputs
├── docs/                             # Multi-language READMEs
├── LICENSE
└── README.md                         # This file
```

> **Why this layout?** Each `plugins/<name>/` folder is a complete plugin in its own right (its own `plugin.json` and `skills/`). The top-level `marketplace.json` just enumerates them with `source` paths. Adding a third plugin = drop a new folder under `plugins/`, append one entry to `marketplace.json`. No coupling between plugins.

## Adding a new plugin to this marketplace

1. Create `plugins/<your-plugin>/.claude-plugin/plugin.json`
2. Add `plugins/<your-plugin>/skills/<your-skill>/SKILL.md` (with frontmatter `name` + `description`)
3. Add the supporting files the skill needs (references/, templates/, etc.)
4. Append a new entry to `.claude-plugin/marketplace.json` `plugins[]` with `source: "./plugins/<your-plugin>"`
5. Bump the marketplace `version` field

That's it. No glue code, no registration step.

## Compatibility

- **Claude Code**: v1.0.0+
- **Cowork mode**: fully supported
- Each plugin's compatibility is documented in its own folder

## License

[MIT](LICENSE).

## Contributing

1. Fork the repo
2. Create a feature branch (`git checkout -b feature/<name>`)
3. Either improve an existing plugin under `plugins/<name>/` or add a new one (see "Adding a new plugin" above)
4. Open a PR

## Changelog

### v2.0.0

- **Repo restructure**: renamed from `python-code-style` to `productivity-toolkit`; converted from single-plugin to multi-plugin marketplace
- **New plugin**: `text-to-diagrams` — 17-type diagram generator (architecture, flow, sequence, ER, pyramid, donut, …) producing one HTML page + per-figure SVGs
- `python-code-style` migrated to `plugins/python-code-style/` (no functional changes; install command updated to namespaced form)

### v1.1.0 (python-code-style)

- Added code review support with detailed feedback and scoring
- Added multi-language README support (10 languages)
- Improved skill trigger conditions

### v1.0.0 (python-code-style)

- Initial release
