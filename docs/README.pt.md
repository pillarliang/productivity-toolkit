# Productivity Toolkit

🌍 **Idioma**: [English](../README.md) | [中文简体](README.zh-cn.md) | [繁體中文](README.zh-tw.md) | [Deutsch](README.de.md) | [Français](README.fr.md) | [Italiano](README.it.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Português](README.pt.md) | [Español](README.es.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code Marketplace](https://img.shields.io/badge/Claude%20Code-Marketplace-blue.svg)](https://code.claude.com/docs/en/plugins)

Um marketplace do Claude Code que reúne plugins de produtividade. Um repositório, vários plugins — instale apenas os que precisar.

## O que tem dentro

| Plugin | Função | Instalação |
| --- | --- | --- |
| **[python-code-style](../plugins/python-code-style/)** | Aplica diretrizes profissionais de estilo Python na geração de código e potencializa revisões estruturadas. Convenções de nomes, formatos de docstrings, ordem de imports, regras PEP 8 / Google styleguide. | `/plugin install python-code-style@productivity-toolkit` |
| **[text-to-diagrams](../plugins/text-to-diagrams/)** | Escolhe entre 17 tipos de diagramas (arquitetura, fluxo, sequência, ER, pirâmide, donut…) e converte texto bruto em uma única página HTML de diagramas mais SVGs independentes. Estilo Kami. | `/plugin install text-to-diagrams@productivity-toolkit` |

Cada plugin é autocontido — seu próprio `plugin.json`, seu próprio `SKILL.md`, suas próprias references e assets. O marketplace apenas os enumera.

## Instalação

### 1. Adicionar o marketplace

No Claude Code, execute uma vez:

```bash
/plugin marketplace add pillarliang/productivity-toolkit
```

### 2. Instalar os plugins desejados

```bash
# Apenas suporte de estilo Python
/plugin install python-code-style@productivity-toolkit

# Apenas diagramas
/plugin install text-to-diagrams@productivity-toolkit

# Ambos
/plugin install python-code-style@productivity-toolkit
/plugin install text-to-diagrams@productivity-toolkit
```

### Alternativa: declarar em settings.json

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

### Alternativa: instalar como skills independentes via `npx skills`

Se você só quer os skills (`SKILL.md` e suas references) sem o wrapper de plugin do Claude Code — útil para compartilhar com outros agentes como Cursor — use o CLI [skills](https://skills.sh/):

```bash
# Ambos os skills, instalados globalmente
npx skills add pillarliang/productivity-toolkit -g

# Apenas um
npx skills add pillarliang/productivity-toolkit -g --skill python-code-style
npx skills add pillarliang/productivity-toolkit -g --skill text-to-diagrams
```

Omita `-g` para instalar no projeto atual. Verifique com `npx skills ls -g`.

### Alternativa: manual

```bash
git clone https://github.com/pillarliang/productivity-toolkit.git
cp -r productivity-toolkit/plugins/python-code-style ~/.claude/plugins/
cp -r productivity-toolkit/plugins/text-to-diagrams ~/.claude/plugins/
```

### Verificar

Execute `/plugin` ou `/plugin list` no Claude Code para confirmar que os plugins estão instalados.

## Atualizar

**Manual:**

```bash
/plugin marketplace update pillarliang/productivity-toolkit
```

Ou via UI: `/plugin` → aba **Marketplaces** → selecione o marketplace → **Update**.

**Atualização automática:**

1. Execute `/plugin`
2. Aba **Marketplaces**
3. Selecione o marketplace alvo
4. **Enable auto-update**

> Marketplaces de terceiros têm a atualização automática desabilitada por padrão. Habilite uma vez e o Claude Code atualizará na inicialização.

## Desinstalar

```bash
/plugin uninstall python-code-style@productivity-toolkit
/plugin uninstall text-to-diagrams@productivity-toolkit

# Ou remova o marketplace inteiro (desinstala todos os seus plugins)
/plugin marketplace remove pillarliang/productivity-toolkit
```

## Estrutura do repositório

```text
productivity-toolkit/
├── .claude-plugin/
│   └── marketplace.json              # Lista os dois plugins
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
│           ├── README.md             # Documentação própria do skill
│           ├── templates/            # 17 templates HTML de diagramas
│           ├── references/           # style.md, diagrams.md, page-shell.html
│           ├── tools/svg-to-png.sh   # Conversor SVG→PNG opcional
│           └── examples/             # Inputs de exemplo + outputs renderizados
├── docs/                             # READMEs multilíngues
├── LICENSE
└── README.md                         # Este arquivo
```

> **Por que esse layout?** Cada pasta `plugins/<nome>/` é um plugin completo por si só (com seu próprio `plugin.json` e `skills/`). O `marketplace.json` raiz apenas os enumera com caminhos `source`. Adicionar um terceiro plugin = soltar uma nova pasta sob `plugins/`, anexar uma entrada ao `marketplace.json`. Sem acoplamento entre plugins.

## Adicionar um novo plugin a este marketplace

1. Crie `plugins/<seu-plugin>/.claude-plugin/plugin.json`
2. Adicione `plugins/<seu-plugin>/skills/<seu-skill>/SKILL.md` (frontmatter com `name` + `description`)
3. Adicione os arquivos de suporte que o skill precisa (references/, templates/, etc.)
4. Anexe uma nova entrada a `plugins[]` em `.claude-plugin/marketplace.json` com `source: "./plugins/<seu-plugin>"`
5. Incremente o campo `version` do marketplace

É só isso. Sem cola, sem etapa de registro.

## Compatibilidade

- **Claude Code**: v1.0.0+
- **Modo Cowork**: totalmente suportado
- A compatibilidade de cada plugin está documentada na sua própria pasta

## Licença

[MIT](../LICENSE).

## Contribuir

1. Faça fork do repositório
2. Crie um branch de feature (`git checkout -b feature/<nome>`)
3. Melhore um plugin existente sob `plugins/<nome>/` ou adicione um novo (veja "Adicionar um novo plugin" acima)
4. Abra um PR

## Changelog

### v2.0.0

- **Reestruturação do repo**: renomeado de `python-code-style` para `productivity-toolkit`; convertido de plugin único para marketplace multi-plugin
- **Novo plugin**: `text-to-diagrams` — gerador de diagramas em 17 tipos (arquitetura, fluxo, sequência, ER, pirâmide, donut…) que produz uma página HTML + SVGs por figura
- `python-code-style` migrado para `plugins/python-code-style/` (sem mudanças funcionais; comando de instalação atualizado para a forma com namespace)

### v1.1.0 (python-code-style)

- Adicionado suporte a revisão de código com feedback detalhado e pontuação
- Adicionado suporte a README multilíngue (10 idiomas)
- Melhoradas as condições de trigger do skill

### v1.0.0 (python-code-style)

- Versão inicial
