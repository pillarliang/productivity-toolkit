> ⚠️ This translation is out of date — repo was restructured in v2.0.0. See [English README](../README.md) or [中文简体](README.zh-cn.md) for the current layout and install instructions.

# Plugin per lo Stile del Codice Python

🌍 **Lingua**: [English](../README.md) | [中文简体](README.zh-cn.md) | [繁體中文](README.zh-tw.md) | [Deutsch](README.de.md) | [Français](README.fr.md) | [Italiano](README.it.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Português](README.pt.md) | [Español](README.es.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code Plugin](https://img.shields.io/badge/Claude%20Code-Plugin-blue.svg)](https://code.claude.com/docs/en/plugins)

Un plugin Claude Code che applica linee guida professionali per lo stile del codice Python in tutta la generazione di codice Python.

## Funzionalità

- **Attivazione Automatica**: Claude segue automaticamente le linee guida di stile Python durante la generazione o la revisione del codice
- **Supporto per la Revisione del Codice**: Revisione del codice Python esistente con feedback dettagliato e valutazione
- **Copertura Completa**: Include le migliori pratiche del settore
  - Convenzioni di denominazione (moduli, classi, funzioni, variabili, costanti)
  - Formato docstring con sezioni Args, Returns, Raises, Yields
  - Regole e ordinamento delle importazioni
  - Standard di formattazione (indentazione, lunghezza riga, spazi)
  - Regole del linguaggio (eccezioni, type hints, comprehension)
- **Riferimenti Dettagliati**: Documentazione di supporto per casi particolari

## Installazione

### Metodo 1: Via Marketplace (Consigliato)

In Claude Code, eseguire:

```bash
# Passo 1: Aggiungere il marketplace
/plugin marketplace add pillarliang/python-code-style

# Passo 2: Installare il plugin
/plugin install python-code-style
```

### Metodo 2: Via settings.json

Aggiungere a `~/.claude/settings.json`:

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

### Metodo 3: Installazione Manuale

```bash
# Clonare il repository
git clone https://github.com/pillarliang/python-code-style.git

# Copiare nella directory dei plugin Claude
cp -r python-code-style ~/.claude/plugins/python-code-style
```

### Verificare l'Installazione

Eseguire `/plugin` o `/plugin list` in Claude Code per confermare l'installazione.

### Aggiornare il Plugin

**Aggiornamento manuale:**

1. Aggiornare l'elenco dei plugin del marketplace, quindi reinstallare:
   ```bash
   /plugin marketplace update pillarliang/python-code-style
   ```

2. Oppure tramite interfaccia interattiva: Eseguire `/plugin`, passare alla scheda **Marketplaces**, selezionare il marketplace, quindi scegliere **Update**.

**Aggiornamento automatico:**

Claude Code supporta gli aggiornamenti automatici per i marketplace e i plugin installati all'avvio:

1. Eseguire `/plugin` per aprire il gestore dei plugin
2. Selezionare la scheda **Marketplaces**
3. Selezionare il marketplace di destinazione
4. Scegliere **Enable auto-update**

> **Nota:** Il marketplace ufficiale Anthropic ha gli aggiornamenti automatici abilitati per impostazione predefinita. I marketplace di terze parti e sviluppati localmente li hanno disabilitati per impostazione predefinita.

## Utilizzo

Una volta installato, il plugin si attiva automaticamente quando chiedi a Claude di:

- Scrivere codice Python
- Creare script o moduli Python
- Refactorizzare codice Python
- Generare funzioni o classi Python
- **Revisionare codice Python esistente**

### Esempi di Prompt

**Generazione Codice:**
```
"Scrivi una funzione Python per analizzare file JSON"

"Crea una classe Python per le connessioni al database"

"Refactorizza questo codice Python per renderlo più pulito"
```

**Revisione Codice:**
```
"Revisiona questo file Python: /path/to/file.py"

"Controlla questo codice Python per problemi di stile"
```

Claude applicherà automaticamente le regole di stile Python, incluse:

- Convenzioni di denominazione corrette (`snake_case` per funzioni, `CapWords` per classi)
- Docstring con sezioni Args, Returns, Raises
- Ordinamento corretto delle importazioni (stdlib → terze parti → locali)
- Indentazione di 4 spazi e limite di 80 caratteri per riga
- Type hints per le firme delle funzioni

### Esempio di Output della Revisione del Codice

Durante la revisione del codice, Claude fornisce feedback strutturato:

```markdown
## Riepilogo della Revisione del Codice

### ✅ Aspetti Positivi
- Denominazione delle funzioni chiara usando snake_case
- Buon uso dei type hints

### ⚠️ Problemi Trovati

#### Problema 1: Documentazione - Docstring mancante
- **Posizione**: Riga 5
- **Problema**: La funzione `process_data` non ha un docstring
- **Suggerimento**: Aggiungere docstring con sezioni Args/Returns/Raises

#### Problema 2: Stile - Argomento predefinito mutabile
- **Posizione**: Riga 10
- **Problema**: `def func(items=[])` usa un valore predefinito mutabile
- **Suggerimento**: Usare `items=None` e inizializzare all'interno della funzione

### 📊 Valutazione Complessiva
- Conformità allo Stile: 7/10
- Documentazione: 5/10
- Qualità del Codice: 8/10
```

## Compatibilità

- **Claude Code**: v1.0.0+
- **Modalità Cowork**: Completamente supportata
- **Versioni Python**: Le regole si applicano a Python 3.8+

## Fonti delle Linee Guida di Stile

Questo plugin è basato su convenzioni di stile Python ampiamente adottate, incluse:

- [PEP 8 – Guida allo Stile per il Codice Python](https://peps.python.org/pep-0008/)
- [PEP 257 – Convenzioni Docstring](https://peps.python.org/pep-0257/)
- [PEP 484 – Type Hints](https://peps.python.org/pep-0484/)
- [Google Python Style Guide](https://google.github.io/styleguide/pyguide.html)

## Licenza

Questo plugin è rilasciato sotto [Licenza MIT](https://opensource.org/licenses/MIT).
