# Python Language Rules

## Table of Contents

1. [Lint](#1-lint)
2. [Imports](#2-imports)
3. [Packages](#3-packages)
4. [Exceptions](#4-exceptions)
5. [Mutable Global State](#5-mutable-global-state)
6. [Nested/Local/Inner Classes and Functions](#6-nestedlocalinner-classes-and-functions)
7. [Comprehensions & Generator Expressions](#7-comprehensions--generator-expressions)
8. [Default Iterators and Operators](#8-default-iterators-and-operators)
9. [Generators](#9-generators)
10. [Lambda Functions](#10-lambda-functions)
11. [Conditional Expressions](#11-conditional-expressions)
12. [Default Argument Values](#12-default-argument-values)
13. [Properties](#13-properties)
14. [True/False Evaluations](#14-truefalse-evaluations)
15. [Type Annotations](#15-type-annotations)

---

## 1. Lint

Run `pylint` over your code using the provided pylintrc.

**Decision**: Suppress warnings only when inappropriate, using comments to explain suppressions.

```python
# Yes:
def do_PUT(self):  # pylint: disable=invalid-name
    ...

# No:
def do_PUT(self):  # NOQA
    ...
```

---

## 2. Imports

Use `import` statements for packages and modules only, not for individual classes or functions.

### Rules

- Use `import x` for importing packages and modules
- Use `from x import y` where `x` is the package prefix and `y` is the module name
- Use `from x import y as z` only if:
  - Two modules named `y` are to be imported
  - `y` conflicts with a top-level name
  - `y` is inconveniently long
- Use `import y as z` only for standard abbreviations (e.g., `np` for `numpy`)

### Examples

```python
# Yes:
import os
import sys
from typing import Mapping, Sequence

import numpy as np
import tensorflow as tf

from myproject.backend import huxley
from myproject.backend.huxley import storage_utils
from myproject.backend.state_machine import main_loop

# No:
from os import path
from myproject.backend.huxley.storage_utils import BigTable  # Don't import classes
```

### Import Formatting

```python
# Yes: Long imports using parentheses
from myproject.backend.huxley.storage_utils import (
    BigTable,
    move_files,
    truncate_tables,
)

# No: Backslash continuation
from myproject.backend.huxley.storage_utils import BigTable, \
    move_files, truncate_tables
```

---

## 3. Packages

Import each module using the full pathname location.

```python
# Yes:
from doctor.who import hierarchical_patterns as hp

# No:
from . import hierarchical_patterns as hp  # Avoid relative imports
```

---

## 4. Exceptions

### Rules

- Exceptions must inherit from an existing exception class (usually `Exception`)
- Exception names should end in `Error`
- Never use catch-all `except:` or catch `Exception` or `StandardError`
- Minimize code in try/except blocks
- Use `finally` for cleanup code

### Examples

```python
# Yes:
class MyError(Exception):
    """Custom exception for my module."""


def connect_to_database(host: str) -> Connection:
    """Connect to database.

    Raises:
        ConnectionError: If connection fails.
    """
    try:
        return _create_connection(host)
    except socket.error as e:
        raise ConnectionError(f"Failed to connect to {host}") from e


# No:
class MyException:  # Missing inheritance
    pass

try:
    do_something()
except:  # Catch-all is forbidden
    pass

try:
    do_something()
except Exception:  # Too broad
    pass
```

### Using `assert`

Never use `assert` for validation that must always run. Use `raise` instead.

```python
# Yes:
if not user.has_permission(action):
    raise PermissionError(f"User cannot perform {action}")

# No:
assert user.has_permission(action)  # May be stripped in optimized mode
```

---

## 5. Mutable Global State

Avoid mutable global state.

### Rules

- Module-level constants are allowed and encouraged
- Constants must be named using `CAPS_WITH_UNDER`
- If mutable globals are needed, declare at module level with leading `_`

```python
# Yes:
MAX_HOLY_HANDGRENADE_COUNT = 3
_cached_connection = None  # Internal mutable state

# No:
connection = None  # Public mutable global
```

---

## 6. Nested/Local/Inner Classes and Functions

Use when closing over a local variable or hiding a utility.

```python
# Yes: Nested function for local utility
def outer_function(items: list[str]) -> list[str]:
    def transform(item: str) -> str:
        return item.upper()

    return [transform(item) for item in items]


# Yes: Nested class in factory pattern
def create_handler(handler_type: str) -> Handler:
    class CustomHandler(Handler):
        def handle(self, data):
            ...

    return CustomHandler()
```

---

## 7. Comprehensions & Generator Expressions

Prefer comprehensions over `map()` and `filter()`.

### Rules

- Comprehensions are allowed for simple cases
- Multiple `for` clauses or filter expressions are not permitted
- Use loops instead for complex logic

```python
# Yes:
squares = [x * x for x in numbers]
even_squares = [x * x for x in numbers if x % 2 == 0]
names = {user.name for user in users}
mapping = {k: v for k, v in pairs}

# No: Too complex
result = [
    (x, y, z)
    for x in range(10)
    for y in range(5)
    if x != y
    for z in range(3)
    if y != z
]

# Use a loop instead:
result = []
for x in range(10):
    for y in range(5):
        if x != y:
            for z in range(3):
                if y != z:
                    result.append((x, y, z))
```

---

## 8. Default Iterators and Operators

Use default iterators and operators for types that support them.

```python
# Yes:
for key in dictionary:
    ...
if key in dictionary:
    ...
for item in list_var:
    ...
for line in file:
    ...

# No:
for key in dictionary.keys():
    ...
if dictionary.has_key(key):
    ...
```

---

## 9. Generators

Use generators for simple cases.

```python
# Yes:
def get_even_numbers(numbers: Iterable[int]) -> Iterator[int]:
    """Yield even numbers from the input."""
    for n in numbers:
        if n % 2 == 0:
            yield n
```

Use "Yields:" instead of "Returns:" in docstrings for generators.

---

## 10. Lambda Functions

Use only for one-liners. Prefer named functions for anything complex.

```python
# Yes:
sorted_users = sorted(users, key=lambda u: u.name)

# No: Too complex for lambda
transform = lambda x: (
    x.strip()
    .lower()
    .replace(" ", "_")
    if x
    else ""
)

# Yes: Use a named function instead
def normalize_string(x: str | None) -> str:
    """Normalize string to lowercase with underscores."""
    if not x:
        return ""
    return x.strip().lower().replace(" ", "_")
```

---

## 11. Conditional Expressions

Use only for simple cases.

```python
# Yes:
result = "yes" if condition else "no"
x = 1 if cond else 2

# No: Too complex
result = (
    func_one(var_one, var_two, var_three, var_four)
    if condition
    else func_two(var_five, var_six)
)
```

---

## 12. Default Argument Values

Never use mutable objects as default values.

```python
# Yes:
def function(items: list[str] | None = None) -> list[str]:
    if items is None:
        items = []
    return items


# No: Mutable default
def function(items: list[str] = []) -> list[str]:
    return items
```

**Default values are evaluated once at module load time**, so mutable defaults are shared across all calls.

---

## 13. Properties

Use properties for simple attribute access that needs logic.

```python
# Yes:
class Circle:
    def __init__(self, radius: float) -> None:
        self._radius = radius

    @property
    def radius(self) -> float:
        return self._radius

    @radius.setter
    def radius(self, value: float) -> None:
        if value < 0:
            raise ValueError("Radius cannot be negative")
        self._radius = value

    @property
    def area(self) -> float:
        return 3.14159 * self._radius ** 2
```

---

## 14. True/False Evaluations

Use implicit boolean evaluation where possible.

```python
# Yes:
if not users:
    print("No users")
if items:
    process(items)
if value is None:
    value = default

# No:
if len(users) == 0:
    print("No users")
if items != []:
    process(items)
if value == None:  # Use 'is' for None
    value = default
```

### Special Cases

Use explicit comparisons for integers that might be 0:

```python
# Yes:
if count is not None:  # 0 is valid
    process(count)

# No:
if count:  # Incorrectly skips when count == 0
    process(count)
```

---

## 15. Type Annotations

### Rules

- Add type annotations to all public functions
- Use `from __future__ import annotations` for forward references
- Avoid `typing.Any` except when truly necessary

### Basic Types

```python
def greeting(name: str) -> str:
    return f"Hello, {name}"


def process_items(items: list[str], count: int = 10) -> dict[str, int]:
    ...
```

### Complex Types

```python
from collections.abc import Callable, Iterable, Mapping, Sequence
from typing import TypeVar

T = TypeVar("T")


def first(items: Sequence[T]) -> T | None:
    return items[0] if items else None


def apply_all(
    items: Iterable[T],
    func: Callable[[T], T],
) -> list[T]:
    return [func(item) for item in items]
```

### Type Annotation Spacing

```python
# Yes: No space before colon, space after
def function(param: str) -> None:
    ...

x: int = 5

# Yes: Spaces around = for default values with type annotations
def function(param: str = "default") -> None:
    ...

# No:
def function(param : str) -> None:  # Space before colon
    ...
def function(param:str) -> None:  # No space after colon
    ...
```
