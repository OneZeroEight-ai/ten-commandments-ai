# Testing Quick Reference

## Common Commands

```bash
# Run all tests
python -m pytest

# Run with coverage
python -m pytest --cov=commandments

# Run specific test
python -m pytest tests/test_commandments/test_basic.py

# Run with output
python -m pytest -v
```

## Key Files

- tests/test_commandments/test_basic.py - Core tests
- pytest.ini - Configuration
- docs/testing/guide.md - Full guide

## Current Coverage: 100%

Components tested:
- EquityMetrics
- HarmPrevention
- ValueAlignment
