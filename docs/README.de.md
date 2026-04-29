# Productivity Toolkit

🌍 **Sprache**: [English](../README.md) | [中文简体](README.zh-cn.md) | [繁體中文](README.zh-tw.md) | [Deutsch](README.de.md) | [Français](README.fr.md) | [Italiano](README.it.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Português](README.pt.md) | [Español](README.es.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code Marketplace](https://img.shields.io/badge/Claude%20Code-Marketplace-blue.svg)](https://code.claude.com/docs/en/plugins)

Ein Claude-Code-Marketplace, der Produktivitäts-Plugins bündelt. Ein Repository, mehrere Plugins — installieren Sie nur, was Sie brauchen.

## Inhalt

| Plugin | Funktion | Installation |
| --- | --- | --- |
| **[python-code-style](../plugins/python-code-style/)** | Erzwingt professionelle Python-Stilrichtlinien bei Codegenerierung und unterstützt strukturierte Code-Reviews. Namenskonventionen, Docstring-Formate, Importreihenfolge, PEP 8 / Google Styleguide. | `/plugin install python-code-style@productivity-toolkit` |
| **[text-to-diagrams](../plugins/text-to-diagrams/)** | Wählt aus 17 Diagrammtypen (Architektur, Flussdiagramm, Sequenz, ER, Pyramide, Donut …) und verwandelt Rohtext in eine einzelne HTML-Seite mit Diagrammen plus eigenständige SVGs. Kami-Stil. | `/plugin install text-to-diagrams@productivity-toolkit` |

Jedes Plugin ist in sich geschlossen — eigene `plugin.json`, eigene `SKILL.md`, eigene Referenzen und Assets. Der Marketplace listet sie nur auf.

## Installation

### 1. Marketplace hinzufügen

Einmalig in Claude Code ausführen:

```bash
/plugin marketplace add pillarliang/productivity-toolkit
```

### 2. Gewünschte Plugins installieren

```bash
# Nur Python-Stil
/plugin install python-code-style@productivity-toolkit

# Nur Diagramme
/plugin install text-to-diagrams@productivity-toolkit

# Beide
/plugin install python-code-style@productivity-toolkit
/plugin install text-to-diagrams@productivity-toolkit
```

### Alternative: Deklaration in settings.json

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

### Alternative: Als eigenständige Skills via `npx skills` installieren

Wenn Sie nur die Skills selbst (`SKILL.md` und Referenzdateien) ohne Claude-Code-Plugin-Wrapper möchten — etwa um sie mit anderen Agenten wie Cursor zu teilen — verwenden Sie das [skills](https://skills.sh/) CLI:

```bash
# Beide Skills global installieren
npx skills add pillarliang/productivity-toolkit -g

# Nur einer
npx skills add pillarliang/productivity-toolkit -g --skill python-code-style
npx skills add pillarliang/productivity-toolkit -g --skill text-to-diagrams
```

Ohne `-g` wird ins aktuelle Projekt installiert. Prüfen mit `npx skills ls -g`.

### Alternative: Manuell

```bash
git clone https://github.com/pillarliang/productivity-toolkit.git
cp -r productivity-toolkit/plugins/python-code-style ~/.claude/plugins/
cp -r productivity-toolkit/plugins/text-to-diagrams ~/.claude/plugins/
```

### Überprüfen

`/plugin` oder `/plugin list` in Claude Code ausführen, um zu bestätigen, dass die Plugins installiert sind.

## Aktualisieren

**Manuell:**

```bash
/plugin marketplace update pillarliang/productivity-toolkit
```

Oder per UI: `/plugin` → Tab **Marketplaces** → Marketplace auswählen → **Update**.

**Automatisches Update:**

1. `/plugin` ausführen
2. Tab **Marketplaces**
3. Den Ziel-Marketplace auswählen
4. **Enable auto-update**

> Bei Drittanbieter-Marketplaces ist Auto-Update standardmäßig deaktiviert. Einmal aktivieren, dann aktualisiert Claude Code beim Start.

## Deinstallation

```bash
/plugin uninstall python-code-style@productivity-toolkit
/plugin uninstall text-to-diagrams@productivity-toolkit

# Oder den gesamten Marketplace entfernen (deinstalliert alle seine Plugins)
/plugin marketplace remove pillarliang/productivity-toolkit
```

## Repository-Struktur

```text
productivity-toolkit/
├── .claude-plugin/
│   └── marketplace.json              # Listet beide Plugins
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
│           ├── README.md             # Skill-spezifische Dokumentation
│           ├── templates/            # 17 Diagramm-HTML-Templates
│           ├── references/           # style.md, diagrams.md, page-shell.html
│           ├── tools/svg-to-png.sh   # Optionaler SVG→PNG-Konverter
│           └── examples/             # Beispiel-Inputs + gerenderte Outputs
├── docs/                             # Mehrsprachige READMEs
├── LICENSE
└── README.md                         # Diese Datei
```

> **Warum dieses Layout?** Jeder `plugins/<name>/`-Ordner ist ein eigenständiges Plugin (mit eigener `plugin.json` und `skills/`). Die oberste `marketplace.json` listet sie lediglich mit `source`-Pfaden auf. Drittes Plugin hinzufügen = neuen Ordner unter `plugins/` ablegen, einen Eintrag an `marketplace.json` anhängen. Keine Kopplung zwischen Plugins.

## Neues Plugin zu diesem Marketplace hinzufügen

1. `plugins/<dein-plugin>/.claude-plugin/plugin.json` anlegen
2. `plugins/<dein-plugin>/skills/<dein-skill>/SKILL.md` hinzufügen (Frontmatter mit `name` + `description`)
3. Unterstützende Dateien hinzufügen, die das Skill braucht (references/, templates/ etc.)
4. Neuen Eintrag an `.claude-plugin/marketplace.json` `plugins[]` anhängen mit `source: "./plugins/<dein-plugin>"`
5. Das Feld `version` im Marketplace erhöhen

Das war's. Kein Glue Code, kein Registrierungsschritt.

## Kompatibilität

- **Claude Code**: v1.0.0+
- **Cowork-Modus**: vollständig unterstützt
- Die Kompatibilität jedes Plugins ist in dessen eigenem Ordner dokumentiert

## Lizenz

[MIT](../LICENSE).

## Mitwirken

1. Repository forken
2. Feature-Branch erstellen (`git checkout -b feature/<name>`)
3. Entweder ein bestehendes Plugin unter `plugins/<name>/` verbessern oder ein neues hinzufügen (siehe „Neues Plugin hinzufügen" oben)
4. Pull Request öffnen

## Änderungsverlauf

### v2.0.0

- **Repo-Umstrukturierung**: umbenannt von `python-code-style` zu `productivity-toolkit`; vom Single-Plugin- zum Multi-Plugin-Marketplace
- **Neues Plugin**: `text-to-diagrams` — 17-Typen-Diagrammgenerator (Architektur, Flow, Sequenz, ER, Pyramide, Donut …), erzeugt eine HTML-Seite + SVGs pro Figur
- `python-code-style` wurde nach `plugins/python-code-style/` migriert (keine Funktionsänderungen; Installationsbefehl wurde auf die Namespace-Form aktualisiert)

### v1.1.0 (python-code-style)

- Code-Review-Unterstützung mit detailliertem Feedback und Bewertung hinzugefügt
- Mehrsprachiger README-Support (10 Sprachen)
- Verbesserte Skill-Trigger-Bedingungen

### v1.0.0 (python-code-style)

- Erstveröffentlichung
