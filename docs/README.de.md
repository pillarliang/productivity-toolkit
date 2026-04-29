> ⚠️ This translation is out of date — repo was restructured in v2.0.0. See [English README](../README.md) or [中文简体](README.zh-cn.md) for the current layout and install instructions.

# Python Code Style Plugin

🌍 **Sprache**: [English](../README.md) | [中文简体](README.zh-cn.md) | [繁體中文](README.zh-tw.md) | [Deutsch](README.de.md) | [Français](README.fr.md) | [Italiano](README.it.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Português](README.pt.md) | [Español](README.es.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code Plugin](https://img.shields.io/badge/Claude%20Code-Plugin-blue.svg)](https://code.claude.com/docs/en/plugins)

Ein Claude Code Plugin, das professionelle Python-Stilrichtlinien für die gesamte Python-Codegenerierung durchsetzt.

## Funktionen

- **Automatische Aktivierung**: Claude befolgt automatisch Python-Stilrichtlinien beim Generieren oder Überprüfen von Code
- **Code-Review-Unterstützung**: Überprüfung vorhandenen Python-Codes mit detailliertem Feedback und Bewertung
- **Umfassende Abdeckung**: Enthält branchenübliche Best Practices
  - Namenskonventionen (Module, Klassen, Funktionen, Variablen, Konstanten)
  - Docstring-Format mit Args, Returns, Raises, Yields-Abschnitten
  - Import-Regeln und -Reihenfolge
  - Formatierungsstandards (Einrückung, Zeilenlänge, Leerzeichen)
  - Sprachregeln (Ausnahmen, Typ-Hinweise, Comprehensions)
- **Detaillierte Referenzen**: Unterstützende Dokumentation für Grenzfälle

## Installation

### Methode 1: Über Marketplace (Empfohlen)

In Claude Code ausführen:

```bash
# Schritt 1: Marketplace hinzufügen
/plugin marketplace add pillarliang/python-code-style

# Schritt 2: Plugin installieren
/plugin install python-code-style
```

### Methode 2: Über settings.json

Zu `~/.claude/settings.json` hinzufügen:

```json
{
  "extraKnownMarketplaces": {
    "python-code-style": {
      "source": {
        "source": "github",
        "repo": "pillarliang/python-code-style"
      }
    }
  },
  "enabledPlugins": {
    "python-code-style@python-code-style": true
  }
}
```

### Methode 3: Manuelle Installation

```bash
# Repository klonen
git clone https://github.com/pillarliang/python-code-style.git

# In Claude-Plugin-Verzeichnis kopieren
cp -r python-code-style ~/.claude/plugins/python-code-style
```

### Installation überprüfen

Führen Sie `/plugin` oder `/plugin list` in Claude Code aus, um die Installation zu bestätigen.

### Plugin aktualisieren

**Manuelle Aktualisierung:**

1. Aktualisieren Sie die Marketplace-Plugin-Liste und installieren Sie erneut:
   ```bash
   /plugin marketplace update pillarliang/python-code-style
   ```

2. Oder über die interaktive Benutzeroberfläche: Führen Sie `/plugin` aus, wechseln Sie zum **Marketplaces**-Tab, wählen Sie den Marketplace aus und dann **Update**.

**Automatische Aktualisierung:**

Claude Code unterstützt automatische Updates für Marketplaces und installierte Plugins beim Start:

1. Führen Sie `/plugin` aus, um den Plugin-Manager zu öffnen
2. Wählen Sie den **Marketplaces**-Tab
3. Wählen Sie den Ziel-Marketplace aus
4. Wählen Sie **Enable auto-update**

> **Hinweis:** Der offizielle Anthropic Marketplace hat automatische Updates standardmäßig aktiviert. Drittanbieter- und lokal entwickelte Marketplaces haben es standardmäßig deaktiviert.

## Verwendung

Nach der Installation wird das Plugin automatisch aktiviert, wenn Sie Claude bitten:

- Python-Code zu schreiben
- Python-Skripte oder -Module zu erstellen
- Python-Code zu refaktorisieren
- Python-Funktionen oder -Klassen zu generieren
- **Vorhandenen Python-Code zu überprüfen**

### Beispiel-Prompts

**Code-Generierung:**
```
"Schreibe eine Python-Funktion zum Parsen von JSON-Dateien"

"Erstelle eine Python-Klasse für Datenbankverbindungen"

"Refaktorisiere diesen Python-Code, um ihn sauberer zu machen"
```

**Code-Review:**
```
"Überprüfe diese Python-Datei: /path/to/file.py"

"Prüfe diesen Python-Code auf Stilprobleme"
```

Claude wendet automatisch Python-Stilrichtlinien an, einschließlich:

- Korrekte Namenskonventionen (`snake_case` für Funktionen, `CapWords` für Klassen)
- Docstrings mit Args, Returns, Raises-Abschnitten
- Korrekte Import-Reihenfolge (Standardbibliothek → Drittanbieter → Lokal)
- 4-Leerzeichen-Einrückung und 80-Zeichen-Zeilenlimit
- Typ-Hinweise für Funktionssignaturen

### Code-Review-Ausgabebeispiel

Bei der Codeüberprüfung liefert Claude strukturiertes Feedback:

```markdown
## Code-Review-Zusammenfassung

### ✅ Positiv
- Klare Funktionsbenennung mit snake_case
- Gute Verwendung von Typ-Hinweisen

### ⚠️ Gefundene Probleme

#### Problem 1: Dokumentation - Fehlender Docstring
- **Stelle**: Zeile 5
- **Problem**: Funktion `process_data` hat keinen Docstring
- **Vorschlag**: Docstring mit Args/Returns/Raises-Abschnitten hinzufügen

#### Problem 2: Stil - Veränderliches Standardargument
- **Stelle**: Zeile 10
- **Problem**: `def func(items=[])` verwendet veränderlichen Standardwert
- **Vorschlag**: `items=None` verwenden und innerhalb der Funktion initialisieren

### 📊 Gesamtbewertung
- Stil-Konformität: 7/10
- Dokumentation: 5/10
- Code-Qualität: 8/10
```

## Kompatibilität

- **Claude Code**: v1.0.0+
- **Cowork-Modus**: Vollständig unterstützt
- **Python-Versionen**: Regeln gelten für Python 3.8+

## Stilrichtlinien-Quellen

Dieses Plugin basiert auf weit verbreiteten Python-Stilkonventionen, einschließlich:

- [PEP 8 – Style Guide for Python Code](https://peps.python.org/pep-0008/)
- [PEP 257 – Docstring Conventions](https://peps.python.org/pep-0257/)
- [PEP 484 – Type Hints](https://peps.python.org/pep-0484/)
- [Google Python Style Guide](https://google.github.io/styleguide/pyguide.html)

## Lizenz

Dieses Plugin ist unter der [MIT-Lizenz](https://opensource.org/licenses/MIT) lizenziert.
