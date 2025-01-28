# Tests for Ten Commandments AI

This directory contains tests for the core ethical AI components.

## Running Tests

Run all tests:
```bash
python -m pytest
```

Run with coverage report:
```bash
python -m pytest --cov=commandments
```

## Test Structure

- `test_commandments/` - Tests for core ethical components
  - `test_basic.py` - Tests for EquityMetrics, HarmPrevention, and ValueAlignment

## Adding Tests

When adding new tests:
1. Follow the existing test structure
2. Include both unit tests and integration tests
3. Verify ethical principles are maintained
4. Add clear assertions and documentation
