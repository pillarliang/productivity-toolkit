# Docstrings (Google Style)

## Table of Contents

1. [Overview](#overview)
2. [Module Docstrings](#module-docstrings)
3. [Function and Method Docstrings](#function-and-method-docstrings)
4. [Class Docstrings](#class-docstrings)
5. [Special Sections](#special-sections)
6. [Complete Examples](#complete-examples)

---

## Overview

All public modules, functions, classes, and methods require docstrings. Docstrings should describe **what** the code does, not **how** it does it.

### General Rules

- Use triple double quotes `"""`
- First line is a summary ending with a period
- One blank line after summary if more content follows
- Use imperative mood ("Return" not "Returns")

---

## Module Docstrings

Every file should start with a docstring describing the module contents.

```python
"""One-line summary of module purpose.

Longer description explaining module functionality, main classes,
and typical usage patterns. May span multiple paragraphs.

Example:
    Basic usage example::

        from mypackage import mymodule
        result = mymodule.do_something()

Attributes:
    MODULE_CONSTANT: Description of module-level constant.

Todo:
    * Add feature X
    * Fix issue Y
"""

from __future__ import annotations

MODULE_CONSTANT = 42
```

---

## Function and Method Docstrings

### Basic Format

```python
def function_name(arg1: str, arg2: int) -> bool:
    """Short summary in imperative mood.

    Longer description if needed. Explain what the function does,
    any important side effects, and usage context.

    Args:
        arg1: Description of first argument.
        arg2: Description of second argument.

    Returns:
        Description of return value.

    Raises:
        ExceptionType: When this exception is raised.
    """
```

### Simple Functions

Very obvious functions may have a one-line docstring.

```python
def double(x: int) -> int:
    """Return double the input value."""
    return x * 2
```

### Args Section

```python
def fetch_data(
    url: str,
    timeout: float = 30.0,
    headers: dict[str, str] | None = None,
    *,
    verify_ssl: bool = True,
) -> bytes:
    """Fetch data from a URL.

    Args:
        url: The URL to fetch from.
        timeout: Request timeout in seconds. Defaults to 30.0.
        headers: Optional HTTP headers to include.
        verify_ssl: Whether to verify SSL certificates.
            Defaults to True.

    Returns:
        The response body as bytes.

    Raises:
        ConnectionError: If the connection fails.
        TimeoutError: If the request times out.
    """
```

Notes:
- Don't include `self` or `cls` in Args
- Describe default values in the description
- Indent continuation lines by 4 spaces
- Type is optional in description (already in signature)

### Returns Section

```python
def parse_config(path: str) -> dict[str, Any]:
    """Parse configuration file.

    Args:
        path: Path to the configuration file.

    Returns:
        A dictionary containing configuration values. Keys are
        setting names and values are the configured values.
        Example:
            {
                "host": "localhost",
                "port": 8080,
                "debug": True,
            }
    """
```

For multiple return values:

```python
def get_user_info(user_id: int) -> tuple[str, int, bool]:
    """Get user information.

    Args:
        user_id: The user's unique identifier.

    Returns:
        A tuple containing:
            - name: The user's display name.
            - age: The user's age in years.
            - active: Whether the user account is active.
    """
```

### Yields Section (for Generators)

```python
def read_chunks(path: str, size: int = 1024) -> Iterator[bytes]:
    """Read file in chunks.

    Args:
        path: Path to the file.
        size: Chunk size in bytes.

    Yields:
        Chunks of file content up to `size` bytes.
    """
```

### Raises Section

```python
def divide(a: float, b: float) -> float:
    """Divide two numbers.

    Args:
        a: The dividend.
        b: The divisor.

    Returns:
        The quotient of a divided by b.

    Raises:
        ZeroDivisionError: If b is zero.
        TypeError: If a or b is not a number.
    """
```

---

## Class Docstrings

### Basic Format

```python
class MyClass:
    """Short summary of the class.

    Longer description explaining the class purpose, behavior,
    and typical usage patterns.

    Attributes:
        attr1: Description of first attribute.
        attr2: Description of second attribute.

    Example:
        Basic usage::

            obj = MyClass(value=42)
            result = obj.process()
    """

    def __init__(self, value: int) -> None:
        """Initialize MyClass.

        Args:
            value: Initial value for processing.
        """
        self.attr1 = value
        self.attr2 = []
```

### Attributes Section

Document public attributes. Private attributes (prefixed with `_`) generally don't need documentation unless they're important for subclassing.

```python
class Configuration:
    """Application configuration container.

    Attributes:
        host: Server hostname.
        port: Server port number.
        debug: Enable debug mode.
        log_level: Logging verbosity level.
    """

    def __init__(
        self,
        host: str = "localhost",
        port: int = 8080,
    ) -> None:
        """Initialize configuration.

        Args:
            host: Server hostname.
            port: Server port number.
        """
        self.host = host
        self.port = port
        self.debug = False
        self.log_level = "INFO"
```

---

## Special Sections

### Examples Section

```python
def format_name(first: str, last: str) -> str:
    """Format a full name.

    Args:
        first: First name.
        last: Last name.

    Returns:
        Formatted full name.

    Example:
        >>> format_name("John", "Doe")
        'John Doe'
        >>> format_name("Jane", "Smith")
        'Jane Smith'
    """
```

### Note Section

```python
def process_data(data: list[int]) -> list[int]:
    """Process data in place.

    Args:
        data: List of integers to process.

    Returns:
        The same list, modified in place.

    Note:
        This function modifies the input list directly.
        Pass a copy if you need to preserve the original.
    """
```

### Warning Section

```python
def delete_all(path: str) -> None:
    """Delete all files in directory.

    Args:
        path: Directory path.

    Warning:
        This operation cannot be undone. All files in the
        directory will be permanently deleted.
    """
```

### See Also Section

```python
def serialize(obj: Any) -> str:
    """Serialize object to JSON string.

    Args:
        obj: Object to serialize.

    Returns:
        JSON string representation.

    See Also:
        deserialize: Convert JSON string back to object.
        json.dumps: Standard library JSON serialization.
    """
```

### Section Order

When multiple sections are present, use this order:

1. Summary line
2. Extended description
3. Example
4. Args
5. Returns (or Yields)
6. Raises
7. Note
8. Warning
9. See Also
10. Todo

---

## Complete Examples

### Complete Module Example

```python
"""Data validation utilities.

This module provides functions for validating user input and data
structures. It supports common validation patterns including type
checking, range validation, and format validation.

Example:
    Validate user input::

        from validation import validate_email, validate_age

        email = validate_email("user@example.com")
        age = validate_age(25)

Attributes:
    EMAIL_PATTERN: Regex pattern for email validation.
    MIN_AGE: Minimum allowed age.
    MAX_AGE: Maximum allowed age.
"""

from __future__ import annotations

import re
from typing import Pattern

EMAIL_PATTERN: Pattern[str] = re.compile(
    r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$"
)
MIN_AGE: int = 0
MAX_AGE: int = 150


class ValidationError(ValueError):
    """Raised when validation fails.

    Attributes:
        field: The field that failed validation.
        value: The invalid value.
        message: Human-readable error message.
    """

    def __init__(
        self,
        field: str,
        value: object,
        message: str,
    ) -> None:
        """Initialize ValidationError.

        Args:
            field: Name of the field that failed validation.
            value: The value that failed validation.
            message: Description of why validation failed.
        """
        super().__init__(message)
        self.field = field
        self.value = value
        self.message = message


def validate_email(email: str) -> str:
    """Validate and normalize an email address.

    Validates that the input is a properly formatted email address
    and normalizes it to lowercase.

    Args:
        email: The email address to validate.

    Returns:
        The normalized (lowercase) email address.

    Raises:
        ValidationError: If the email format is invalid.

    Example:
        >>> validate_email("User@Example.COM")
        'user@example.com'
        >>> validate_email("invalid")
        Traceback (most recent call last):
            ...
        ValidationError: Invalid email format
    """
    email = email.strip().lower()

    if not EMAIL_PATTERN.match(email):
        raise ValidationError(
            field="email",
            value=email,
            message="Invalid email format",
        )

    return email


def validate_age(age: int) -> int:
    """Validate that age is within acceptable range.

    Args:
        age: The age to validate.

    Returns:
        The validated age.

    Raises:
        ValidationError: If age is not within MIN_AGE and MAX_AGE.

    Example:
        >>> validate_age(25)
        25
        >>> validate_age(-1)
        Traceback (most recent call last):
            ...
        ValidationError: Age must be between 0 and 150
    """
    if not MIN_AGE <= age <= MAX_AGE:
        raise ValidationError(
            field="age",
            value=age,
            message=f"Age must be between {MIN_AGE} and {MAX_AGE}",
        )

    return age


class DataValidator:
    """Validates data dictionaries against schemas.

    A flexible validator that checks data dictionaries against
    defined schemas with support for required fields, type checking,
    and custom validators.

    Attributes:
        schema: The validation schema dictionary.
        strict: Whether to reject unknown fields.

    Example:
        Define and use a validator::

            schema = {
                "name": {"type": str, "required": True},
                "age": {"type": int, "required": True},
                "email": {"type": str, "required": False},
            }

            validator = DataValidator(schema)
            validator.validate({"name": "John", "age": 30})
    """

    def __init__(
        self,
        schema: dict[str, dict],
        *,
        strict: bool = False,
    ) -> None:
        """Initialize the DataValidator.

        Args:
            schema: Validation schema. Each key is a field name and
                each value is a dict with 'type' and 'required' keys.
            strict: If True, reject fields not in schema.
        """
        self.schema = schema
        self.strict = strict

    def validate(self, data: dict[str, object]) -> dict[str, object]:
        """Validate data against the schema.

        Args:
            data: Dictionary of data to validate.

        Returns:
            The validated data dictionary.

        Raises:
            ValidationError: If validation fails for any field.
        """
        validated = {}

        for field, rules in self.schema.items():
            if field in data:
                value = data[field]
                expected_type = rules.get("type")

                if expected_type and not isinstance(value, expected_type):
                    raise ValidationError(
                        field=field,
                        value=value,
                        message=f"Expected {expected_type.__name__}",
                    )

                validated[field] = value

            elif rules.get("required", False):
                raise ValidationError(
                    field=field,
                    value=None,
                    message="Field is required",
                )

        if self.strict:
            unknown = set(data.keys()) - set(self.schema.keys())
            if unknown:
                raise ValidationError(
                    field=str(unknown),
                    value=None,
                    message="Unknown fields in strict mode",
                )

        return validated


def main() -> None:
    """Demonstrate validation utilities."""
    email = validate_email("Test@Example.com")
    print(f"Validated email: {email}")

    age = validate_age(25)
    print(f"Validated age: {age}")


if __name__ == "__main__":
    main()
```
