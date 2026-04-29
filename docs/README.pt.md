> ⚠️ This translation is out of date — repo was restructured in v2.0.0. See [English README](../README.md) or [中文简体](README.zh-cn.md) for the current layout and install instructions.

# Plugin de Estilo de Código Python

🌍 **Idioma**: [English](../README.md) | [中文简体](README.zh-cn.md) | [繁體中文](README.zh-tw.md) | [Deutsch](README.de.md) | [Français](README.fr.md) | [Italiano](README.it.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Português](README.pt.md) | [Español](README.es.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code Plugin](https://img.shields.io/badge/Claude%20Code-Plugin-blue.svg)](https://code.claude.com/docs/en/plugins)

Um plugin Claude Code que aplica diretrizes profissionais de estilo Python para toda geração de código Python.

## Funcionalidades

- **Ativação Automática**: Claude segue automaticamente as diretrizes de estilo Python ao gerar ou revisar código
- **Suporte a Revisão de Código**: Revise código Python existente com feedback detalhado e pontuação
- **Cobertura Abrangente**: Inclui melhores práticas da indústria
  - Convenções de nomenclatura (módulos, classes, funções, variáveis, constantes)
  - Formato de docstring com seções Args, Returns, Raises, Yields
  - Regras e ordenação de imports
  - Padrões de formatação (indentação, comprimento de linha, espaços em branco)
  - Regras de linguagem (exceções, type hints, comprehensions)
- **Referências Detalhadas**: Documentação de suporte para casos especiais

## Instalação

### Método 1: Via Marketplace (Recomendado)

No Claude Code, execute:

```bash
# Passo 1: Adicionar o marketplace
/plugin marketplace add pillarliang/python-code-style

# Passo 2: Instalar o plugin
/plugin install python-code-style
```

### Método 2: Via settings.json

Adicione ao seu `~/.claude/settings.json`:

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

### Método 3: Instalação Manual

```bash
# Clonar o repositório
git clone https://github.com/pillarliang/python-code-style.git

# Copiar para o diretório de plugins do Claude
cp -r python-code-style ~/.claude/plugins/python-code-style
```

### Verificar Instalação

Execute `/plugin` ou `/plugin list` no Claude Code para confirmar a instalação.

### Atualizar Plugin

**Atualização manual:**

1. Atualize a lista de plugins do marketplace e reinstale:
   ```bash
   /plugin marketplace update pillarliang/python-code-style
   ```

2. Ou via interface interativa: Execute `/plugin`, mude para a aba **Marketplaces**, selecione o marketplace e escolha **Update**.

**Atualização automática:**

Claude Code suporta atualizações automáticas para marketplaces e plugins instalados na inicialização:

1. Execute `/plugin` para abrir o gerenciador de plugins
2. Selecione a aba **Marketplaces**
3. Selecione o marketplace de destino
4. Escolha **Enable auto-update**

> **Nota:** O marketplace oficial da Anthropic tem atualizações automáticas habilitadas por padrão. Marketplaces de terceiros e desenvolvidos localmente têm desabilitado por padrão.

## Uso

Uma vez instalado, o plugin ativa automaticamente quando você pede ao Claude para:

- Escrever código Python
- Criar scripts ou módulos Python
- Refatorar código Python
- Gerar funções ou classes Python
- **Revisar código Python existente**

### Exemplos de Prompts

**Geração de Código:**
```
"Escreva uma função Python para analisar arquivos JSON"

"Crie uma classe Python para conexões com banco de dados"

"Refatore este código Python para ficar mais limpo"
```

**Revisão de Código:**
```
"Revise este arquivo Python: /path/to/file.py"

"Verifique este código Python quanto a problemas de estilo"
```

Claude aplicará automaticamente as regras de estilo Python, incluindo:

- Convenções de nomenclatura adequadas (`snake_case` para funções, `CapWords` para classes)
- Docstrings com seções Args, Returns, Raises
- Ordenação correta de imports (stdlib → terceiros → local)
- Indentação de 4 espaços e limite de 80 caracteres por linha
- Type hints para assinaturas de funções

### Exemplo de Saída da Revisão de Código

Ao revisar código, Claude fornece feedback estruturado:

```markdown
## Resumo da Revisão de Código

### ✅ Pontos Positivos
- Nomenclatura de funções clara usando snake_case
- Bom uso de type hints

### ⚠️ Problemas Encontrados

#### Problema 1: Documentação - Docstring ausente
- **Localização**: Linha 5
- **Problema**: Função `process_data` não possui docstring
- **Sugestão**: Adicionar docstring com seções Args/Returns/Raises

#### Problema 2: Estilo - Argumento padrão mutável
- **Localização**: Linha 10
- **Problema**: `def func(items=[])` usa valor padrão mutável
- **Sugestão**: Usar `items=None` e inicializar dentro da função

### 📊 Avaliação Geral
- Conformidade de Estilo: 7/10
- Documentação: 5/10
- Qualidade do Código: 8/10
```

## Compatibilidade

- **Claude Code**: v1.0.0+
- **Modo Cowork**: Totalmente suportado
- **Versões Python**: Regras aplicam-se ao Python 3.8+

## Fontes das Diretrizes de Estilo

Este plugin é baseado em convenções de estilo Python amplamente adotadas, incluindo:

- [PEP 8 – Guia de Estilo para Código Python](https://peps.python.org/pep-0008/)
- [PEP 257 – Convenções de Docstring](https://peps.python.org/pep-0257/)
- [PEP 484 – Type Hints](https://peps.python.org/pep-0484/)
- [Guia de Estilo Python do Google](https://google.github.io/styleguide/pyguide.html)

## Licença

Este plugin está licenciado sob a [Licença MIT](https://opensource.org/licenses/MIT).
