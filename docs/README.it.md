# Productivity Toolkit

🌍 **Lingua**: [English](../README.md) | [中文简体](README.zh-cn.md) | [繁體中文](README.zh-tw.md) | [Deutsch](README.de.md) | [Français](README.fr.md) | [Italiano](README.it.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Português](README.pt.md) | [Español](README.es.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code Marketplace](https://img.shields.io/badge/Claude%20Code-Marketplace-blue.svg)](https://code.claude.com/docs/en/plugins)

Un marketplace di Claude Code che raccoglie plugin di produttività. Un repository, più plugin — installa solo quelli che ti servono.

## Cosa contiene

| Plugin | Funzione | Installazione |
| --- | --- | --- |
| **[python-code-style](../plugins/python-code-style/)** | Applica linee guida professionali di stile Python sulla generazione di codice e supporta revisioni strutturate. Convenzioni di nomi, formati di docstring, ordine degli import, regole PEP 8 / Google styleguide. | `/plugin install python-code-style@productivity-toolkit` |
| **[text-to-diagrams](../plugins/text-to-diagrams/)** | Sceglie tra 17 tipi di diagrammi (architettura, flusso, sequenza, ER, piramide, donut…) e trasforma testo grezzo in una singola pagina HTML di diagrammi più SVG indipendenti. Stile Kami. | `/plugin install text-to-diagrams@productivity-toolkit` |

Ogni plugin è autonomo — il suo `plugin.json`, il suo `SKILL.md`, le sue references e i suoi asset. Il marketplace si limita a elencarli.

## Installazione

### 1. Aggiungi il marketplace

In Claude Code, esegui una volta:

```bash
/plugin marketplace add pillarliang/productivity-toolkit
```

### 2. Installa i plugin che vuoi

```bash
# Solo supporto stile Python
/plugin install python-code-style@productivity-toolkit

# Solo diagrammi
/plugin install text-to-diagrams@productivity-toolkit

# Entrambi
/plugin install python-code-style@productivity-toolkit
/plugin install text-to-diagrams@productivity-toolkit
```

### Alternativa: dichiarazione in settings.json

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

### Alternativa: installare come skill autonomi via `npx skills`

Se vuoi solo gli skill (`SKILL.md` e relative reference) senza il wrapper plugin di Claude Code — utile per condividerli con altri agenti come Cursor — usa il CLI [skills](https://skills.sh/):

```bash
# Entrambi gli skill, installati globalmente
npx skills add pillarliang/productivity-toolkit -g

# Solo uno
npx skills add pillarliang/productivity-toolkit -g --skill python-code-style
npx skills add pillarliang/productivity-toolkit -g --skill text-to-diagrams
```

Ometti `-g` per installare nel progetto corrente. Verifica con `npx skills ls -g`.

### Alternativa: manuale

```bash
git clone https://github.com/pillarliang/productivity-toolkit.git
cp -r productivity-toolkit/plugins/python-code-style ~/.claude/plugins/
cp -r productivity-toolkit/plugins/text-to-diagrams ~/.claude/plugins/
```

### Verifica

Esegui `/plugin` o `/plugin list` in Claude Code per confermare che i plugin sono installati.

## Aggiornamento

**Manuale:**

```bash
/plugin marketplace update pillarliang/productivity-toolkit
```

Oppure via UI: `/plugin` → tab **Marketplaces** → seleziona il marketplace → **Update**.

**Aggiornamento automatico:**

1. Esegui `/plugin`
2. Tab **Marketplaces**
3. Seleziona il marketplace di destinazione
4. **Enable auto-update**

> I marketplace di terze parti hanno l'aggiornamento automatico disabilitato per default. Abilitalo una volta e Claude Code aggiornerà all'avvio.

## Disinstallazione

```bash
/plugin uninstall python-code-style@productivity-toolkit
/plugin uninstall text-to-diagrams@productivity-toolkit

# Oppure rimuovi l'intero marketplace (disinstalla tutti i suoi plugin)
/plugin marketplace remove pillarliang/productivity-toolkit
```

## Struttura del repository

```text
productivity-toolkit/
├── .claude-plugin/
│   └── marketplace.json              # Elenca entrambi i plugin
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
│           ├── README.md             # Documentazione propria dello skill
│           ├── templates/            # 17 template HTML di diagrammi
│           ├── references/           # style.md, diagrams.md, page-shell.html
│           ├── tools/svg-to-png.sh   # Convertitore opzionale SVG→PNG
│           └── examples/             # Input di esempio + output renderizzati
├── docs/                             # README multilingue
├── LICENSE
└── README.md                         # Questo file
```

> **Perché questo layout?** Ogni cartella `plugins/<nome>/` è un plugin completo a sé stante (con il proprio `plugin.json` e `skills/`). Il `marketplace.json` di livello superiore li enumera soltanto con percorsi `source`. Aggiungere un terzo plugin = mettere una nuova cartella sotto `plugins/`, aggiungere una voce a `marketplace.json`. Nessun accoppiamento tra plugin.

## Aggiungere un nuovo plugin a questo marketplace

1. Crea `plugins/<tuo-plugin>/.claude-plugin/plugin.json`
2. Aggiungi `plugins/<tuo-plugin>/skills/<tuo-skill>/SKILL.md` (frontmatter con `name` + `description`)
3. Aggiungi i file di supporto necessari allo skill (references/, templates/, ecc.)
4. Aggiungi una nuova voce a `plugins[]` in `.claude-plugin/marketplace.json` con `source: "./plugins/<tuo-plugin>"`
5. Incrementa il campo `version` del marketplace

Tutto qui. Niente glue code, nessun passo di registrazione.

## Compatibilità

- **Claude Code**: v1.0.0+
- **Modalità Cowork**: pienamente supportata
- La compatibilità di ogni plugin è documentata nella sua cartella

## Licenza

[MIT](../LICENSE).

## Contribuire

1. Forka il repository
2. Crea un feature branch (`git checkout -b feature/<nome>`)
3. Migliora un plugin esistente in `plugins/<nome>/` oppure aggiungine uno nuovo (vedi "Aggiungere un nuovo plugin" sopra)
4. Apri una PR

## Changelog

### v2.0.0

- **Ristrutturazione del repo**: rinominato da `python-code-style` a `productivity-toolkit`; convertito da plugin singolo a marketplace multi-plugin
- **Nuovo plugin**: `text-to-diagrams` — generatore di diagrammi 17-tipi (architettura, flusso, sequenza, ER, piramide, donut…) che produce una pagina HTML + SVG per figura
- `python-code-style` migrato in `plugins/python-code-style/` (nessuna modifica funzionale; comando di installazione aggiornato alla forma con namespace)

### v1.1.0 (python-code-style)

- Aggiunto supporto code review con feedback dettagliato e punteggio
- Aggiunto supporto README multilingue (10 lingue)
- Migliorate le condizioni di trigger dello skill

### v1.0.0 (python-code-style)

- Versione iniziale
