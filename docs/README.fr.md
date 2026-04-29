# Productivity Toolkit

🌍 **Langue**: [English](../README.md) | [中文简体](README.zh-cn.md) | [繁體中文](README.zh-tw.md) | [Deutsch](README.de.md) | [Français](README.fr.md) | [Italiano](README.it.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Português](README.pt.md) | [Español](README.es.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code Marketplace](https://img.shields.io/badge/Claude%20Code-Marketplace-blue.svg)](https://code.claude.com/docs/en/plugins)

Un marketplace Claude Code regroupant des plugins de productivité. Un dépôt, plusieurs plugins — installez seulement ceux dont vous avez besoin.

## Contenu

| Plugin | Rôle | Installation |
| --- | --- | --- |
| **[python-code-style](../plugins/python-code-style/)** | Applique des règles de style Python professionnelles à la génération de code et alimente les revues de code structurées. Conventions de nommage, formats de docstrings, ordre des imports, règles PEP 8 / Google styleguide. | `/plugin install python-code-style@productivity-toolkit` |
| **[text-to-diagrams](../plugins/text-to-diagrams/)** | Choisit parmi 17 types de diagrammes (architecture, flux, séquence, ER, pyramide, donut…) et transforme du texte brut en une page HTML unique de diagrammes plus des SVG autonomes. Style Kami. | `/plugin install text-to-diagrams@productivity-toolkit` |

Chaque plugin est autonome — son propre `plugin.json`, son propre `SKILL.md`, ses propres références et assets. Le marketplace ne fait que les répertorier.

## Installation

### 1. Ajouter le marketplace

Dans Claude Code, exécutez une fois:

```bash
/plugin marketplace add pillarliang/productivity-toolkit
```

### 2. Installer les plugins voulus

```bash
# Style Python uniquement
/plugin install python-code-style@productivity-toolkit

# Diagrammes uniquement
/plugin install text-to-diagrams@productivity-toolkit

# Les deux
/plugin install python-code-style@productivity-toolkit
/plugin install text-to-diagrams@productivity-toolkit
```

### Alternative: déclarer dans settings.json

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

### Alternative: installer comme skills autonomes via `npx skills`

Si vous voulez seulement les skills (`SKILL.md` et leurs références) sans l'enveloppe plugin Claude Code — utile pour les partager avec d'autres agents comme Cursor — utilisez le CLI [skills](https://skills.sh/):

```bash
# Les deux skills, en global
npx skills add pillarliang/productivity-toolkit -g

# Un seul
npx skills add pillarliang/productivity-toolkit -g --skill python-code-style
npx skills add pillarliang/productivity-toolkit -g --skill text-to-diagrams
```

Omettez `-g` pour installer dans le projet courant. Vérifiez avec `npx skills ls -g`.

### Alternative: manuel

```bash
git clone https://github.com/pillarliang/productivity-toolkit.git
cp -r productivity-toolkit/plugins/python-code-style ~/.claude/plugins/
cp -r productivity-toolkit/plugins/text-to-diagrams ~/.claude/plugins/
```

### Vérifier

Exécutez `/plugin` ou `/plugin list` dans Claude Code pour confirmer que les plugins sont installés.

## Mise à jour

**Manuelle:**

```bash
/plugin marketplace update pillarliang/productivity-toolkit
```

Ou via l'UI: `/plugin` → onglet **Marketplaces** → sélectionnez le marketplace → **Update**.

**Mise à jour automatique:**

1. Exécutez `/plugin`
2. Onglet **Marketplaces**
3. Sélectionnez le marketplace cible
4. **Enable auto-update**

> Les marketplaces tiers ont la mise à jour auto désactivée par défaut. Activez-la une fois et Claude Code rafraîchira au démarrage.

## Désinstallation

```bash
/plugin uninstall python-code-style@productivity-toolkit
/plugin uninstall text-to-diagrams@productivity-toolkit

# Ou supprimer le marketplace entier (désinstalle tous ses plugins)
/plugin marketplace remove pillarliang/productivity-toolkit
```

## Structure du dépôt

```text
productivity-toolkit/
├── .claude-plugin/
│   └── marketplace.json              # Liste les deux plugins
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
│           ├── README.md             # Documentation propre au skill
│           ├── templates/            # 17 templates HTML de diagrammes
│           ├── references/           # style.md, diagrams.md, page-shell.html
│           ├── tools/svg-to-png.sh   # Convertisseur SVG→PNG optionnel
│           └── examples/             # Entrées d'exemple + sorties rendues
├── docs/                             # READMEs multilingues
├── LICENSE
└── README.md                         # Ce fichier
```

> **Pourquoi cette organisation?** Chaque dossier `plugins/<nom>/` est un plugin complet à part entière (avec son propre `plugin.json` et ses `skills/`). Le `marketplace.json` racine ne fait que les énumérer avec des chemins `source`. Ajouter un troisième plugin = déposer un nouveau dossier sous `plugins/`, ajouter une entrée à `marketplace.json`. Aucun couplage entre les plugins.

## Ajouter un nouveau plugin à ce marketplace

1. Créez `plugins/<votre-plugin>/.claude-plugin/plugin.json`
2. Ajoutez `plugins/<votre-plugin>/skills/<votre-skill>/SKILL.md` (frontmatter avec `name` + `description`)
3. Ajoutez les fichiers dont le skill a besoin (references/, templates/, etc.)
4. Ajoutez une nouvelle entrée à `plugins[]` dans `.claude-plugin/marketplace.json` avec `source: "./plugins/<votre-plugin>"`
5. Incrémentez le champ `version` du marketplace

C'est tout. Pas de code de liaison, pas d'étape d'enregistrement.

## Compatibilité

- **Claude Code**: v1.0.0+
- **Mode Cowork**: entièrement supporté
- La compatibilité de chaque plugin est documentée dans son propre dossier

## Licence

[MIT](../LICENSE).

## Contribuer

1. Forkez le dépôt
2. Créez une branche de feature (`git checkout -b feature/<nom>`)
3. Améliorez un plugin existant sous `plugins/<nom>/` ou ajoutez-en un nouveau (voir "Ajouter un nouveau plugin" ci-dessus)
4. Ouvrez une PR

## Journal des modifications

### v2.0.0

- **Restructuration du dépôt**: renommé de `python-code-style` en `productivity-toolkit`; converti de plugin unique en marketplace multi-plugins
- **Nouveau plugin**: `text-to-diagrams` — générateur de diagrammes en 17 types (architecture, flux, séquence, ER, pyramide, donut…) produisant une page HTML + des SVG par figure
- `python-code-style` migré dans `plugins/python-code-style/` (aucun changement fonctionnel; commande d'installation mise à jour vers la forme avec namespace)

### v1.1.0 (python-code-style)

- Ajout du support de revue de code avec feedback détaillé et notation
- Ajout du support README multilingue (10 langues)
- Conditions de déclenchement du skill améliorées

### v1.0.0 (python-code-style)

- Version initiale
