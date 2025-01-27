# Example System Tests

This directory contains test cases for the example implementations of the Ten Commandments for AI.

## Test Structure

- `financial/` - Tests for the financial decision system
- `content_moderation/` - Tests for the content moderation system
- `resource_allocation/` - Tests for the resource allocation system
- `recommendation/` - Tests for the recommendation system

## Running Tests

Run all tests:
```bash
python -m pytest tests/test_examples/
```

Run specific test suite:
```bash
python -m pytest tests/test_examples/financial/
python -m pytest tests/test_examples/content_moderation/
python -m pytest tests/test_examples/resource_allocation/
python -m pytest tests/test_examples/recommendation/
```

## Test Coverage

Each test suite includes:
- Basic functionality tests
- Edge case handling
- Error scenarios
- Ethical principle verification
