# Python Style Rules

## Table of Contents

1. [Semicolons](#1-semicolons)
2. [Line Length](#2-line-length)
3. [Parentheses](#3-parentheses)
4. [Indentation](#4-indentation)
5. [Blank Lines](#5-blank-lines)
6. [Whitespace](#6-whitespace)
7. [Shebang Line](#7-shebang-line)
8. [Comments and Docstrings](#8-comments-and-docstrings)
9. [Punctuation, Spelling, and Grammar](#9-punctuation-spelling-and-grammar)
10. [Strings](#10-strings)
11. [Logging](#11-logging)
12. [Error Messages](#12-error-messages)
13. [Files, Sockets, and Database Connections](#13-files-sockets-and-database-connections)
14. [TODO Comments](#14-todo-comments)
15. [Imports Formatting](#15-imports-formatting)
16. [Statements](#16-statements)
17. [Getters and Setters](#17-getters-and-setters)
18. [Main](#18-main)
19. [Function Length](#19-function-length)

---

## 1. Semicolons

Do not use semicolons to terminate lines or put multiple statements on a line.

```python
# Yes:
x = 1
y = 2
print(x)
print(y)

# No:
x = 1; y = 2
print(x); print(y)
```

---

## 2. Line Length

Maximum line length is **80 characters**.

### Exceptions

- Long import statements
- URLs, pathnames, or long flags in comments
- Long string module-level constants
- Pylint disable comments

### Line Continuation

Use Python's implicit line joining inside parentheses, brackets, and braces.

```python
# Yes: Using parentheses
result = function_with_long_name(
    argument_one,
    argument_two,
    argument_three,
)

long_string = (
    "This is a very long string that needs to be "
    "split across multiple lines."
)

# No: Using backslash
result = function_with_long_name(argument_one, argument_two, \
    argument_three)
```

---

## 3. Parentheses

Use parentheses sparingly. Do not use them in return or conditional statements unless using implicit line continuation.

```python
# Yes:
if foo:
    bar()
while x:
    x = bar()
return value
return spam, eggs

# No:
if (foo):
    bar()
while (x):
    x = bar()
return (value)
```

---

## 4. Indentation

Indent code blocks with **4 spaces**.

Never use tabs. Configure your editor to insert spaces when you press Tab.

### Continuation Alignment

```python
# Yes: Aligned with opening delimiter
foo = long_function_name(var_one, var_two,
                         var_three, var_four)

# Yes: Hanging indent with 4 spaces
foo = long_function_name(
    var_one,
    var_two,
    var_three,
    var_four,
)

# No: Arguments on first line when not using hanging indent
foo = long_function_name(var_one, var_two,
    var_three, var_four)  # Only 4 spaces, should align
```

### Dictionary and List Indentation

```python
# Yes: Consistent indentation
my_dict = {
    "key1": "value1",
    "key2": "value2",
    "key3": "value3",
}

my_list = [
    "item1",
    "item2",
    "item3",
]

# Yes: Short enough for one line
my_dict = {"key": "value"}
my_list = ["a", "b", "c"]
```

---

## 5. Blank Lines

- **Two blank lines** between top-level definitions (functions, classes)
- **One blank line** between method definitions inside a class
- **One blank line** after the class definition line
- **No blank line** after `def` line
- Use blank lines sparingly inside functions for logical sections

```python
class MyClass:

    def __init__(self) -> None:
        self.value = 0

    def method_one(self) -> None:
        """First method."""
        pass

    def method_two(self) -> None:
        """Second method."""
        pass


def top_level_function() -> None:
    """A top-level function."""
    pass


def another_function() -> None:
    """Another top-level function."""
    pass
```

---

## 6. Whitespace

### Standard Rules

```python
# Yes:
spam(ham[1], {eggs: 2}, [])
spam(1)
dict["key"] = list[index]
x = 1
x == 1

# No:
spam( ham[ 1 ], { eggs: 2 }, [ ] )
spam (1)
dict ["key"] = list [index]
x=1
x==1
```

### No Trailing Whitespace

Remove trailing whitespace at end of lines.

### Operators

```python
# Yes: Spaces around binary operators
x = a + b
x = a * b - c
y = (a + b) * (c - d)

# Yes: No spaces for keyword arguments or default values (without annotations)
def function(arg1, arg2=None):
    call(arg1=1, arg2=2)

# Yes: Spaces around = for defaults WITH type annotations
def function(arg1: int, arg2: str = "default") -> None:
    ...
```

---

## 7. Shebang Line

Use `#!/usr/bin/env python3` for executable scripts.

```python
#!/usr/bin/env python3
"""Module docstring."""

import os
```

Files intended to be imported only should not have a shebang.

---

## 8. Comments and Docstrings

### Block Comments

- Start with `# ` (hash and space)
- Indent to same level as code

```python
# This is a block comment explaining
# what the following code does.
result = complex_calculation()
```

### Inline Comments

- Use sparingly
- At least 2 spaces from statement
- Start with `# ` (hash and space)

```python
x = x + 1  # Compensate for border
```

### Docstrings

See [references/docstrings.md](docstrings.md) for complete format.

---

## 9. Punctuation, Spelling, and Grammar

Use proper punctuation, spelling, and grammar in comments and docstrings.

- End sentences with periods
- Use proper capitalization
- Spell correctly

```python
# Yes:
# This function calculates the sum of two numbers.
# It returns the result as an integer.

# No:
# this function calculate sum of 2 number
# return the result
```

---

## 10. Strings

### Quote Characters

Use double quotes `"` for strings. Use single quotes `'` only to avoid escaping.

```python
# Yes:
message = "Hello, world!"
sql = "SELECT * FROM users WHERE name = 'John'"

# No:
message = 'Hello, world!'
```

### String Formatting

Prefer f-strings for formatting.

```python
# Yes: f-strings
name = "World"
message = f"Hello, {name}!"

# Yes: When f-string not possible
message = "Hello, {}!".format(name)

# No: % formatting
message = "Hello, %s!" % name
```

### Multi-line Strings

```python
# Yes: Using parentheses for long strings
long_string = (
    "This is a very long string that needs to be "
    "split across multiple lines for readability."
)

# Yes: textwrap.dedent for indented multi-line
import textwrap

query = textwrap.dedent("""\
    SELECT *
    FROM users
    WHERE active = true
    """)
```

---

## 11. Logging

Use the logging module instead of print for production code.

```python
import logging

logger = logging.getLogger(__name__)


def process_data(data: list) -> None:
    logger.info("Processing %d items", len(data))
    try:
        result = transform(data)
    except ValueError:
        logger.exception("Failed to transform data")
        raise
    logger.debug("Result: %s", result)
```

Use `%s` formatting in logging calls, not f-strings (for performance).

---

## 12. Error Messages

Error messages should be clear and actionable.

```python
# Yes:
raise ValueError(
    f"Expected positive integer, got {value!r}"
)

# No:
raise ValueError("bad value")
```

---

## 13. Files, Sockets, and Database Connections

Use context managers (`with` statement) for resources that need cleanup.

```python
# Yes:
with open("file.txt") as f:
    contents = f.read()

with database.connect() as conn:
    cursor = conn.cursor()
    cursor.execute(query)

# No:
f = open("file.txt")
contents = f.read()
f.close()  # May not be called if exception occurs
```

---

## 14. TODO Comments

Format: `# TODO(username): Description`

```python
# TODO(kl@gmail.com): Use a "*" here for string repetition.
# TODO(Zeke): Change this to use relations.
# TODO(bug 12345): Remove this after the migration.
```

---

## 15. Imports Formatting

### Order

1. `__future__` imports
2. Standard library imports
3. Third-party imports
4. Local application imports

Each group separated by a blank line. Sort alphabetically within groups.

```python
from __future__ import annotations

import collections
import os
import sys
from collections.abc import Mapping, Sequence
from typing import Any

import numpy as np
import pandas as pd
import tensorflow as tf

from myproject import utils
from myproject.backend import api
from myproject.backend.storage import BigTable
```

### Multiple Imports

```python
# Yes: One import per line
import os
import sys

# Yes: Multiple items from same module
from collections.abc import Mapping, Sequence
from typing import Any, Optional, Union

# Yes: Long import with parentheses
from myproject.backend.storage import (
    BigTable,
    SmallTable,
    TinyTable,
)
```

---

## 16. Statements

Generally, one statement per line.

```python
# Yes:
if foo:
    bar()
else:
    baz()

# Yes: Short if statement without else
if foo: bar()

# No:
if foo: bar()
else: baz()

# No:
try: something()
except: pass
```

---

## 17. Getters and Setters

Use properties instead of explicit getters/setters.

```python
# Yes: Property
class MyClass:
    def __init__(self) -> None:
        self._value = 0

    @property
    def value(self) -> int:
        return self._value

    @value.setter
    def value(self, val: int) -> None:
        self._value = val


# No: Explicit getters/setters
class MyClass:
    def __init__(self) -> None:
        self._value = 0

    def get_value(self) -> int:
        return self._value

    def set_value(self, val: int) -> None:
        self._value = val
```

---

## 18. Main

All executable files should have a main function and use the idiom:

```python
def main() -> None:
    """Main entry point."""
    ...


if __name__ == "__main__":
    main()
```

---

## 19. Function Length

Prefer small and focused functions.

- If a function exceeds 40 lines, consider splitting it
- Each function should do one thing
- Extract helper functions for complex logic

```python
# Yes: Small, focused functions
def calculate_total(items: list[Item]) -> float:
    """Calculate total price of items."""
    return sum(item.price for item in items)


def apply_discount(total: float, discount: float) -> float:
    """Apply percentage discount to total."""
    return total * (1 - discount / 100)


def process_order(items: list[Item], discount: float) -> float:
    """Process order and return final price."""
    total = calculate_total(items)
    return apply_discount(total, discount)
```
