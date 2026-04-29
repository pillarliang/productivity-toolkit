> ⚠️ This translation is out of date — repo was restructured in v2.0.0. See [English README](../README.md) or [中文简体](README.zh-cn.md) for the current layout and install instructions.

# Plugin de Estilo de Código Python

🌍 **Idioma**: [English](../README.md) | [中文简体](README.zh-cn.md) | [繁體中文](README.zh-tw.md) | [Deutsch](README.de.md) | [Français](README.fr.md) | [Italiano](README.it.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Português](README.pt.md) | [Español](README.es.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code Plugin](https://img.shields.io/badge/Claude%20Code-Plugin-blue.svg)](https://code.claude.com/docs/en/plugins)

Un plugin de Claude Code que aplica directrices profesionales de estilo Python para toda la generación de código Python.

## Características

- **Activación Automática**: Claude sigue automáticamente las directrices de estilo Python al generar o revisar código
- **Soporte de Revisión de Código**: Revisa código Python existente con retroalimentación detallada y puntuación
- **Cobertura Integral**: Incluye las mejores prácticas de la industria
  - Convenciones de nomenclatura (módulos, clases, funciones, variables, constantes)
  - Formato de docstring con secciones Args, Returns, Raises, Yields
  - Reglas y ordenamiento de imports
  - Estándares de formato (indentación, longitud de línea, espacios en blanco)
  - Reglas del lenguaje (excepciones, type hints, comprehensions)
- **Referencias Detalladas**: Documentación de soporte para casos especiales

## Instalación

### Método 1: Vía Marketplace (Recomendado)

En Claude Code, ejecuta:

```bash
# Paso 1: Agregar el marketplace
/plugin marketplace add pillarliang/python-code-style

# Paso 2: Instalar el plugin
/plugin install python-code-style
```

### Método 2: Vía settings.json

Agrega a tu `~/.claude/settings.json`:

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

### Método 3: Instalación Manual

```bash
# Clonar el repositorio
git clone https://github.com/pillarliang/python-code-style.git

# Copiar al directorio de plugins de Claude
cp -r python-code-style ~/.claude/plugins/python-code-style
```

### Verificar Instalación

Ejecuta `/plugin` o `/plugin list` en Claude Code para confirmar la instalación.

### Actualizar Plugin

**Actualización manual:**

1. Actualiza la lista de plugins del marketplace y reinstala:
   ```bash
   /plugin marketplace update pillarliang/python-code-style
   ```

2. O mediante interfaz interactiva: Ejecuta `/plugin`, cambia a la pestaña **Marketplaces**, selecciona el marketplace y elige **Update**.

**Actualización automática:**

Claude Code soporta actualizaciones automáticas para marketplaces y plugins instalados al inicio:

1. Ejecuta `/plugin` para abrir el administrador de plugins
2. Selecciona la pestaña **Marketplaces**
3. Selecciona el marketplace objetivo
4. Elige **Enable auto-update**

> **Nota:** El marketplace oficial de Anthropic tiene las actualizaciones automáticas habilitadas por defecto. Los marketplaces de terceros y desarrollados localmente las tienen deshabilitadas por defecto.

## Uso

Una vez instalado, el plugin se activa automáticamente cuando le pides a Claude:

- Escribir código Python
- Crear scripts o módulos Python
- Refactorizar código Python
- Generar funciones o clases Python
- **Revisar código Python existente**

### Ejemplos de Prompts

**Generación de Código:**
```
"Escribe una función Python para analizar archivos JSON"

"Crea una clase Python para conexiones de base de datos"

"Refactoriza este código Python para hacerlo más limpio"
```

**Revisión de Código:**
```
"Revisa este archivo Python: /path/to/file.py"

"Verifica este código Python en busca de problemas de estilo"
```

Claude aplicará automáticamente las reglas de estilo Python, incluyendo:

- Convenciones de nomenclatura apropiadas (`snake_case` para funciones, `CapWords` para clases)
- Docstrings con secciones Args, Returns, Raises
- Ordenamiento correcto de imports (stdlib → terceros → local)
- Indentación de 4 espacios y límite de 80 caracteres por línea
- Type hints para firmas de funciones

### Ejemplo de Salida de Revisión de Código

Al revisar código, Claude proporciona retroalimentación estructurada:

```markdown
## Resumen de Revisión de Código

### ✅ Aspectos Positivos
- Nomenclatura de funciones clara usando snake_case
- Buen uso de type hints

### ⚠️ Problemas Encontrados

#### Problema 1: Documentación - Docstring faltante
- **Ubicación**: Línea 5
- **Problema**: La función `process_data` no tiene docstring
- **Sugerencia**: Agregar docstring con secciones Args/Returns/Raises

#### Problema 2: Estilo - Argumento por defecto mutable
- **Ubicación**: Línea 10
- **Problema**: `def func(items=[])` usa valor por defecto mutable
- **Sugerencia**: Usar `items=None` e inicializar dentro de la función

### 📊 Evaluación General
- Cumplimiento de Estilo: 7/10
- Documentación: 5/10
- Calidad del Código: 8/10
```

## Compatibilidad

- **Claude Code**: v1.0.0+
- **Modo Cowork**: Totalmente soportado
- **Versiones de Python**: Las reglas aplican para Python 3.8+

## Fuentes de las Directrices de Estilo

Este plugin está basado en convenciones de estilo Python ampliamente adoptadas, incluyendo:

- [PEP 8 – Guía de Estilo para Código Python](https://peps.python.org/pep-0008/)
- [PEP 257 – Convenciones de Docstring](https://peps.python.org/pep-0257/)
- [PEP 484 – Type Hints](https://peps.python.org/pep-0484/)
- [Guía de Estilo Python de Google](https://google.github.io/styleguide/pyguide.html)

## Licencia

Este plugin está licenciado bajo la [Licencia MIT](https://opensource.org/licenses/MIT).
