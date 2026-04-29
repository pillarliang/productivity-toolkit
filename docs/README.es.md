# Productivity Toolkit

🌍 **Idioma**: [English](../README.md) | [中文简体](README.zh-cn.md) | [繁體中文](README.zh-tw.md) | [Deutsch](README.de.md) | [Français](README.fr.md) | [Italiano](README.it.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Português](README.pt.md) | [Español](README.es.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code Marketplace](https://img.shields.io/badge/Claude%20Code-Marketplace-blue.svg)](https://code.claude.com/docs/en/plugins)

Un marketplace de Claude Code que agrupa plugins de productividad. Un repositorio, varios plugins — instala solo los que necesites.

## Qué incluye

| Plugin | Función | Instalación |
| --- | --- | --- |
| **[python-code-style](../plugins/python-code-style/)** | Aplica directrices profesionales de estilo Python en la generación de código y potencia revisiones estructuradas. Convenciones de nombres, formatos de docstrings, orden de imports, reglas PEP 8 / Google styleguide. | `/plugin install python-code-style@productivity-toolkit` |
| **[text-to-diagrams](../plugins/text-to-diagrams/)** | Elige entre 17 tipos de diagramas (arquitectura, flujo, secuencia, ER, pirámide, donut…) y convierte texto plano en una sola página HTML con diagramas más SVGs independientes. Estilo Kami. | `/plugin install text-to-diagrams@productivity-toolkit` |

Cada plugin es autocontenido — su propio `plugin.json`, su propio `SKILL.md`, sus propias referencias y assets. El marketplace solo los enumera.

## Instalación

### 1. Añadir el marketplace

En Claude Code, ejecuta una vez:

```bash
/plugin marketplace add pillarliang/productivity-toolkit
```

### 2. Instalar los plugins que quieras

```bash
# Solo soporte de estilo Python
/plugin install python-code-style@productivity-toolkit

# Solo diagramas
/plugin install text-to-diagrams@productivity-toolkit

# Ambos
/plugin install python-code-style@productivity-toolkit
/plugin install text-to-diagrams@productivity-toolkit
```

### Alternativa: declarar en settings.json

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

### Alternativa: instalar como skills independientes vía `npx skills`

Si solo quieres los skills (`SKILL.md` y sus referencias) sin el envoltorio de plugin de Claude Code — útil para compartir con otros agentes como Cursor — usa el CLI de [skills](https://skills.sh/):

```bash
# Ambos skills, instalados globalmente
npx skills add pillarliang/productivity-toolkit -g

# Solo uno
npx skills add pillarliang/productivity-toolkit -g --skill python-code-style
npx skills add pillarliang/productivity-toolkit -g --skill text-to-diagrams
```

Omite `-g` para instalar en el proyecto actual. Verifica con `npx skills ls -g`.

### Alternativa: manual

```bash
git clone https://github.com/pillarliang/productivity-toolkit.git
cp -r productivity-toolkit/plugins/python-code-style ~/.claude/plugins/
cp -r productivity-toolkit/plugins/text-to-diagrams ~/.claude/plugins/
```

### Verificar

Ejecuta `/plugin` o `/plugin list` en Claude Code para confirmar que los plugins están instalados.

## Actualizar

**Manual:**

```bash
/plugin marketplace update pillarliang/productivity-toolkit
```

O por la UI: `/plugin` → pestaña **Marketplaces** → selecciona el marketplace → **Update**.

**Auto-actualización:**

1. Ejecuta `/plugin`
2. Pestaña **Marketplaces**
3. Selecciona el marketplace objetivo
4. **Enable auto-update**

> Los marketplaces de terceros tienen la auto-actualización deshabilitada por defecto. Habilítala una vez y Claude Code refrescará al iniciar.

## Desinstalación

```bash
/plugin uninstall python-code-style@productivity-toolkit
/plugin uninstall text-to-diagrams@productivity-toolkit

# O quita el marketplace entero (desinstala todos sus plugins)
/plugin marketplace remove pillarliang/productivity-toolkit
```

## Estructura del repositorio

```text
productivity-toolkit/
├── .claude-plugin/
│   └── marketplace.json              # Lista ambos plugins
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
│           ├── README.md             # Documentación del skill
│           ├── templates/            # 17 plantillas HTML de diagramas
│           ├── references/           # style.md, diagrams.md, page-shell.html
│           ├── tools/svg-to-png.sh   # Conversor opcional SVG→PNG
│           └── examples/             # Inputs de muestra + outputs renderizados
├── docs/                             # READMEs multilingües
├── LICENSE
└── README.md                         # Este archivo
```

> **¿Por qué este layout?** Cada carpeta `plugins/<nombre>/` es un plugin completo por sí mismo (su propio `plugin.json` y `skills/`). El `marketplace.json` raíz solo los enumera con rutas `source`. Añadir un tercer plugin = soltar una nueva carpeta bajo `plugins/`, añadir una entrada a `marketplace.json`. Sin acoplamiento entre plugins.

## Añadir un nuevo plugin a este marketplace

1. Crea `plugins/<tu-plugin>/.claude-plugin/plugin.json`
2. Añade `plugins/<tu-plugin>/skills/<tu-skill>/SKILL.md` (frontmatter con `name` + `description`)
3. Añade los archivos de soporte que el skill necesita (references/, templates/, etc.)
4. Añade una nueva entrada a `plugins[]` en `.claude-plugin/marketplace.json` con `source: "./plugins/<tu-plugin>"`
5. Incrementa el campo `version` del marketplace

Eso es todo. Sin código pegamento, sin paso de registro.

## Compatibilidad

- **Claude Code**: v1.0.0+
- **Modo Cowork**: totalmente compatible
- La compatibilidad de cada plugin se documenta en su propia carpeta

## Licencia

[MIT](../LICENSE).

## Contribuir

1. Haz fork del repositorio
2. Crea una rama de feature (`git checkout -b feature/<nombre>`)
3. Mejora un plugin existente bajo `plugins/<nombre>/` o añade uno nuevo (ver "Añadir un nuevo plugin" arriba)
4. Abre un PR

## Registro de cambios

### v2.0.0

- **Reestructuración del repo**: renombrado de `python-code-style` a `productivity-toolkit`; convertido de plugin único a marketplace multi-plugin
- **Nuevo plugin**: `text-to-diagrams` — generador de diagramas de 17 tipos (arquitectura, flujo, secuencia, ER, pirámide, donut…) que produce una página HTML + SVGs por figura
- `python-code-style` migrado a `plugins/python-code-style/` (sin cambios funcionales; el comando de instalación pasa a la forma con namespace)

### v1.1.0 (python-code-style)

- Añadido soporte de revisión de código con feedback detallado y puntuación
- Añadido soporte de README multilingüe (10 idiomas)
- Mejoradas las condiciones de activación del skill

### v1.0.0 (python-code-style)

- Versión inicial
