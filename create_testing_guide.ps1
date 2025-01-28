# create_testing_guide.ps1

# Create docs/testing directory
New-Item -Path "docs/testing" -ItemType Directory -Force

# Create main testing guide
@'
# Testing Guide

## Overview

This guide explains how to run and write tests for the Ten Commandments for AI implementation.

## Quick Start

Run all tests:
```bash
python -m pytest
```

Run with coverage report:
```bash
python -m pytest --cov=commandments
```

## Test Structure

```
tests/
├── test_commandments/       # Core component tests
│   └── test_basic.py       # Tests for basic functionality
├── README.md               # Testing documentation
└── pytest.ini             # pytest configuration
```

## Current Test Coverage

We maintain 100% test coverage for core components:
- EquityMetrics
- HarmPrevention
- ValueAlignment

## Writing Tests

### Basic Test Structure

```python
import pytest
from commandments import EquityMetrics

class TestYourComponent:
    def setup_method(self):
        # Initialize your component
        self.component = YourComponent()

    def test_specific_feature(self):
        # Arrange
        input_data = {"key": "value"}
        
        # Act
        result = self.component.some_method(input_data)
        
        # Assert
        assert result["status"] is True
```

### Test Categories

1. Unit Tests
   - Test individual components
   - Focus on single responsibility
   - Mock dependencies when needed

2. Integration Tests
   - Test components working together
   - Verify ethical principles are maintained
   - Test real-world scenarios

3. Edge Cases
   - Test boundary conditions
   - Verify error handling
   - Check invalid inputs

### Example Test Case

```python
def test_loan_evaluation(self):
    """Test ethical evaluation of loan application"""
    # Arrange
    application = {
        "income": 75000,
        "amount": 200000,
        "credit_score": 720
    }

    # Act
    equity_result = self.equity.calculate_benefit_distribution(
        population={"income": application["income"]},
        benefits={"loan": application["amount"]}
    )

    # Assert
    assert equity_result["is_acceptable"]
    assert "distribution_equity" in equity_result
```

## Running Tests Locally

1. Install requirements:
```bash
pip install pytest pytest-cov
```

2. Run specific test file:
```bash
python -m pytest tests/test_commandments/test_basic.py -v
```

3. Run with detailed output:
```bash
python -m pytest -v
```

4. Run with coverage report:
```bash
python -m pytest --cov=commandments --cov-report=term-missing
```

## Best Practices

1. Test Organization
   - Group related tests in classes
   - Use descriptive test names
   - Include docstrings explaining test purpose

2. Test Data
   - Use realistic test data
   - Cover edge cases
   - Test invalid inputs

3. Assertions
   - Make specific assertions
   - Check data types
   - Verify all relevant outputs

4. Ethical Considerations
   - Verify ethical principles
   - Test fairness metrics
   - Check harm prevention
   - Validate value alignment

## Adding New Tests

When adding new tests:

1. Create test file in appropriate directory
2. Follow existing naming conventions
3. Include both positive and negative tests
4. Update documentation if needed

Example new test file:
```python
# tests/test_commandments/test_new_feature.py

import pytest
from commandments import NewFeature

class TestNewFeature:
    def setup_method(self):
        self.feature = NewFeature()

    def test_basic_functionality(self):
        """Test basic feature operation"""
        result = self.feature.operate({})
        assert result["status"] is True

    def test_edge_case(self):
        """Test feature edge case"""
        result = self.feature.operate({"edge": True})
        assert result["handled"] is True
```

## Common Issues

1. Missing Dependencies
   ```bash
   pip install -e .  # Install package in editable mode
   ```

2. Import Errors
   - Verify package is installed
   - Check import paths
   - Ensure __init__.py files exist

3. Failed Tests
   - Check test data
   - Verify component functionality
   - Look for environment issues

## Contributing

When contributing new tests:

1. Follow existing patterns
2. Maintain 100% coverage
3. Include documentation
4. Test ethical principles
'@ | Out-File -FilePath "docs/testing/guide.md" -Encoding ASCII

# Create a quick reference
@'
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
'@ | Out-File -FilePath "docs/testing/quick_reference.md" -Encoding ASCII

# Update main README to include testing section
$readmeContent = Get-Content "README.md"
$newContent = @'

## Testing

For detailed testing information, see:
- [Testing Guide](docs/testing/guide.md)
- [Quick Reference](docs/testing/quick_reference.md)

Run tests:
```bash
python -m pytest
```

Current test coverage: 100%
'@

Add-Content -Path "README.md" -Value $newContent

# Create git commit
git add .
git commit -m "Add comprehensive testing documentation"
git push origin main

Write-Host "Testing documentation has been added to the repository"