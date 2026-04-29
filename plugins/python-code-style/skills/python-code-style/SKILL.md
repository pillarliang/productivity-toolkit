---
name: python-code-style
description: "Professional Python code style enforcement for generation and review. When Claude needs to work with Python code for: (1) Generating Python code, scripts, functions, or classes, (2) Reviewing or auditing existing Python code, (3) Refactoring Python code, (4) Creating .py files, or any Python coding tasks. "
---

# Python Code Style Guide

When generating Python code, strictly follow these professional Python style guidelines. This skill provides comprehensive coding standards based on industry best practices.

## Quick Reference

### Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Module | `lower_with_under` | `my_module.py` |
| Package | `lower_with_under` | `my_package` |
| Class | `CapWords` | `MyClass` |
| Exception | `CapWords` + `Error` | `MyError` |
| Function | `lower_with_under` | `my_function()` |
| Method | `lower_with_under` | `my_method()` |
| Constant | `CAPS_WITH_UNDER` | `MAX_VALUE` |
| Variable | `lower_with_under` | `my_var` |
| Parameter | `lower_with_under` | `my_param` |
| Internal | `_leading_under` | `_internal_var` |

### Essential Formatting Rules

- **Indentation**: 4 spaces (no tabs)
- **Line length**: 80 characters max (exceptions: imports, URLs, pathnames)
- **Blank lines**: 2 between top-level definitions, 1 between methods
- **Imports**: One per line, grouped (stdlib → third-party → local)
- **Strings**: Use `"` for strings, `"""` for docstrings
- **No semicolons** at end of lines
- **No backslash** for line continuation; use parentheses

### Docstring Format

```python
def function_name(arg1: str, arg2: int = 0) -> bool:
    """Short one-line summary.

    Longer description if needed. Explain what the function
    does, not how it does it.

    Args:
        arg1: Description of arg1.
        arg2: Description of arg2. Defaults to 0.

    Returns:
        Description of return value.

    Raises:
        ValueError: When arg1 is empty.
    """
```

### Import Order

```python
# 1. Standard library imports
import os
import sys

# 2. Third-party imports
import numpy as np
import pandas as pd

# 3. Local application imports
from myproject import mymodule
```

## Detailed References

For comprehensive rules, read these reference files as needed:

- **[references/language-rules.md](references/language-rules.md)**: Lint, imports, exceptions, global state, comprehensions, generators, lambda, type annotations
- **[references/style-rules.md](references/style-rules.md)**: Formatting, whitespace, comments, strings, logging, statements
- **[references/naming-conventions.md](references/naming-conventions.md)**: Complete naming rules with examples
- **[references/docstrings.md](references/docstrings.md)**: Full docstring format for modules, classes, functions

## Code Generation Checklist

When generating Python code, ensure:

1. All names follow the naming conventions table above
2. All public functions/methods have proper docstrings with Args/Returns/Raises
3. Imports are properly ordered and formatted
4. Line length does not exceed 80 characters
5. 4-space indentation is used consistently
6. Type hints are included for function signatures
7. Exceptions inherit from appropriate base classes and end with `Error`
8. No mutable default arguments (use `None` instead)
9. Use `is` / `is not` for `None` comparisons
10. Prefer list/dict/set comprehensions over `map()`/`filter()`

## Code Review Checklist

When reviewing Python code, check for these issues and provide specific feedback:

### Naming Issues
- [ ] Variables/functions not using `snake_case`
- [ ] Classes not using `CapWords`
- [ ] Constants not using `CAPS_WITH_UNDER`
- [ ] Internal items missing `_leading_underscore`
- [ ] Unclear or non-descriptive names

### Documentation Issues
- [ ] Missing or incomplete docstrings
- [ ] Docstrings lacking Args/Returns/Raises sections
- [ ] Outdated docstrings not matching actual behavior
- [ ] Missing module-level docstring

### Style Issues
- [ ] Lines exceeding 80 characters
- [ ] Incorrect indentation (not 4 spaces)
- [ ] Wrong import ordering (should be: stdlib → third-party → local)
- [ ] Missing blank lines between top-level definitions
- [ ] Using tabs instead of spaces

### Code Quality Issues
- [ ] Mutable default arguments (e.g., `def func(items=[])`)
- [ ] Using `==` or `!=` for `None` comparisons
- [ ] Using `map()`/`filter()` instead of comprehensions
- [ ] Missing type hints on public functions
- [ ] Bare `except:` clauses without specific exception types
- [ ] Overly broad exception handling

### Review Output Format

When reviewing code, provide feedback in this format:

```
## Code Review Summary

### ✅ What's Good
- [List positive aspects]

### ⚠️ Issues Found

#### Issue 1: [Category] - [Brief Description]
- **Location**: Line X
- **Problem**: [Description]
- **Suggestion**: [How to fix]
- **Example**:
  ```python
  # Before
  [problematic code]

  # After
  [corrected code]
  ```

### 📊 Overall Assessment
- Style Compliance: X/10
- Documentation: X/10
- Code Quality: X/10
```
