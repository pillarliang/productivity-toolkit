# Naming Conventions

## Table of Contents

1. [Overview](#overview)
2. [Names to Avoid](#names-to-avoid)
3. [Naming by Type](#naming-by-type)
4. [File Names](#file-names)
5. [Guidelines from Guido's Recommendations](#guidelines-from-guidos-recommendations)
6. [Mathematical Notation](#mathematical-notation)
7. [Complete Examples](#complete-examples)

---

## Overview

| Type | Public | Internal |
|------|--------|----------|
| Packages | `lower_with_under` | |
| Modules | `lower_with_under` | `_lower_with_under` |
| Classes | `CapWords` | `_CapWords` |
| Exceptions | `CapWords` (ending in `Error`) | |
| Functions | `lower_with_under()` | `_lower_with_under()` |
| Global/Class Constants | `CAPS_WITH_UNDER` | `_CAPS_WITH_UNDER` |
| Global/Class Variables | `lower_with_under` | `_lower_with_under` |
| Instance Variables | `lower_with_under` | `_lower_with_under` |
| Method Names | `lower_with_under()` | `_lower_with_under()` |
| Function/Method Parameters | `lower_with_under` | |
| Local Variables | `lower_with_under` | |
| Type Variables | `CapWords` | |

---

## Names to Avoid

Never use the following:

- Single character names except for:
  - Counters or iterators (`i`, `j`, `k`)
  - Exception identifier in `except` clause (`e`)
  - File handles (`f`)
  - Type variables
- Dashes (`-`) in any name
- `__double_leading_and_trailing_underscore__` names (reserved by Python)
- Offensive terms
- Names that needlessly include the type (`items_list` → `items`)

---

## Naming by Type

### Packages and Modules

```python
# Yes:
import utilities
import my_package
from data_processing import clean_data

# No:
import Utilities
import my-package  # Dashes not allowed
import MyPackage
```

### Classes

Use `CapWords` (PascalCase). Acronyms should be capitalized.

```python
# Yes:
class HTTPServer:
    pass

class MyClass:
    pass

class XMLParser:
    pass

# No:
class httpServer:
    pass

class my_class:
    pass

class XmlParser:  # Inconsistent acronym
    pass
```

### Exceptions

Use `CapWords` ending with `Error`. Do not introduce repetition.

```python
# Yes:
class ConnectionError(Exception):
    pass

class ValidationError(ValueError):
    pass

# No:
class connection_error(Exception):  # Wrong case
    pass

class MyModuleMyModuleError(Exception):  # Repetitive
    pass
```

### Functions and Methods

```python
# Yes:
def calculate_total() -> float:
    pass

def get_user_by_id(user_id: int) -> User:
    pass

def _internal_helper() -> None:
    pass

# No:
def CalculateTotal() -> float:  # Wrong case
    pass

def getUserById(user_id: int) -> User:  # camelCase
    pass
```

### Constants

Module-level constants use `CAPS_WITH_UNDER`.

```python
# Yes:
MAX_CONNECTIONS = 100
DEFAULT_TIMEOUT_SECONDS = 30
PI = 3.14159
_INTERNAL_BUFFER_SIZE = 4096

# No:
MaxConnections = 100
defaultTimeout = 30
```

### Variables

```python
# Yes:
user_name = "John"
total_count = 0
_cached_value = None
items = []

# No:
userName = "John"  # camelCase
TotalCount = 0  # CapWords
Items_List = []  # Mixed style
```

### Instance Variables and Attributes

```python
class User:
    def __init__(self, name: str, age: int) -> None:
        # Yes:
        self.user_name = name
        self.user_age = age
        self._internal_state = {}

        # No:
        self.userName = name  # camelCase
        self.UserAge = age  # CapWords
```

### Method and Function Parameters

```python
# Yes:
def process_data(
    input_file: str,
    output_path: str,
    max_retries: int = 3,
) -> None:
    pass

# No:
def process_data(
    inputFile: str,  # camelCase
    OutputPath: str,  # CapWords
) -> None:
    pass
```

### Type Variables

Use `CapWords` preferring short names.

```python
from typing import TypeVar

# Yes:
T = TypeVar("T")
KT = TypeVar("KT")  # Key type
VT = TypeVar("VT")  # Value type
AnyStr = TypeVar("AnyStr", str, bytes)

# For constrained type variables
Number = TypeVar("Number", int, float)
```

---

## File Names

- Use `.py` extension
- Use `lower_with_under` naming
- No dashes (`-`) in file names
- Executable files may omit extension

```bash
# Yes:
my_module.py
data_processor.py
test_utils.py
run_server  # Executable without extension

# No:
MyModule.py
data-processor.py  # Dashes not allowed
DataProcessor.py
```

---

## Guidelines from Guido's Recommendations

### Internal vs Public

- `_single_leading_underscore`: weak "internal use" indicator
- `single_trailing_underscore_`: used to avoid conflicts with Python keywords
- `__double_leading_underscore`: name mangling in classes

```python
class MyClass:
    def __init__(self) -> None:
        self.public_attr = 1
        self._internal_attr = 2  # Internal by convention
        self.__private_attr = 3  # Name mangled to _MyClass__private_attr

    def public_method(self) -> None:
        pass

    def _internal_method(self) -> None:
        pass


# Avoiding keyword conflicts
def process(class_: type) -> None:  # 'class' is a keyword
    pass

from_ = "start"  # 'from' is a keyword
```

---

## Mathematical Notation

For mathematically heavy code, short variable names that match reference paper notation are acceptable. Document the source.

```python
def calculate_rotation(
    theta: float,
    phi: float,
) -> np.ndarray:
    """Calculate 3D rotation matrix.

    Uses notation from: Smith et al., "3D Transformations" (2020)
    https://example.com/paper

    Args:
        theta: Rotation angle around x-axis (radians).
        phi: Rotation angle around y-axis (radians).

    Returns:
        3x3 rotation matrix.
    """
    c_t, s_t = np.cos(theta), np.sin(theta)
    c_p, s_p = np.cos(phi), np.sin(phi)

    R = np.array([
        [c_p, 0, s_p],
        [s_t * s_p, c_t, -s_t * c_p],
        [-c_t * s_p, s_t, c_t * c_p],
    ])
    return R
```

---

## Complete Examples

### Well-Named Module

```python
#!/usr/bin/env python3
"""User authentication module.

This module provides utilities for user authentication and session
management.
"""

from __future__ import annotations

import hashlib
import secrets
from dataclasses import dataclass
from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from collections.abc import Mapping

# Constants
DEFAULT_SESSION_TIMEOUT_SECONDS = 3600
MAX_LOGIN_ATTEMPTS = 5
_HASH_ALGORITHM = "sha256"


@dataclass
class UserCredentials:
    """Holds user login credentials."""

    user_name: str
    password_hash: str
    salt: str


class AuthenticationError(Exception):
    """Raised when authentication fails."""


class SessionExpiredError(Exception):
    """Raised when a session has expired."""


def hash_password(password: str, salt: str | None = None) -> tuple[str, str]:
    """Hash a password with optional salt.

    Args:
        password: The plaintext password.
        salt: Optional salt. Generated if not provided.

    Returns:
        Tuple of (password_hash, salt).
    """
    if salt is None:
        salt = secrets.token_hex(16)

    salted_password = f"{salt}{password}"
    password_hash = hashlib.sha256(salted_password.encode()).hexdigest()

    return password_hash, salt


def verify_credentials(
    credentials: UserCredentials,
    input_password: str,
) -> bool:
    """Verify user credentials.

    Args:
        credentials: Stored user credentials.
        input_password: Password to verify.

    Returns:
        True if password matches, False otherwise.
    """
    computed_hash, _ = hash_password(input_password, credentials.salt)
    return secrets.compare_digest(computed_hash, credentials.password_hash)


def _generate_session_token() -> str:
    """Generate a secure session token."""
    return secrets.token_urlsafe(32)


class SessionManager:
    """Manages user sessions."""

    def __init__(
        self,
        timeout_seconds: int = DEFAULT_SESSION_TIMEOUT_SECONDS,
    ) -> None:
        """Initialize the session manager.

        Args:
            timeout_seconds: Session timeout in seconds.
        """
        self._timeout_seconds = timeout_seconds
        self._active_sessions: dict[str, str] = {}

    def create_session(self, user_id: str) -> str:
        """Create a new session for a user.

        Args:
            user_id: The user's unique identifier.

        Returns:
            The session token.
        """
        token = _generate_session_token()
        self._active_sessions[token] = user_id
        return token

    def validate_session(self, token: str) -> str:
        """Validate a session token.

        Args:
            token: The session token to validate.

        Returns:
            The user ID associated with the session.

        Raises:
            SessionExpiredError: If the session is invalid or expired.
        """
        user_id = self._active_sessions.get(token)
        if user_id is None:
            raise SessionExpiredError("Invalid or expired session")
        return user_id


def main() -> None:
    """Demonstrate authentication usage."""
    password = "secure_password_123"
    password_hash, salt = hash_password(password)

    credentials = UserCredentials(
        user_name="john_doe",
        password_hash=password_hash,
        salt=salt,
    )

    is_valid = verify_credentials(credentials, password)
    print(f"Credentials valid: {is_valid}")


if __name__ == "__main__":
    main()
```
