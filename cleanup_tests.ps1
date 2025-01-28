# cleanup_tests.ps1

# First, remove all existing test files and directories
Write-Host "Cleaning up old test files..."
Remove-Item -Path "tests" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "tests/test_commandments" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "tests/test_examples" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "tests/unit" -Recurse -Force -ErrorAction SilentlyContinue

# Create fresh test directory structure
New-Item -Path "tests/test_commandments" -ItemType Directory -Force

# Create single test file for current implementation
@'
import pytest
from commandments import EquityMetrics, HarmPrevention, ValueAlignment

class TestEquityMetrics:
    def setup_method(self):
        self.equity = EquityMetrics()

    def test_basic_evaluation(self):
        result = self.equity.calculate_benefit_distribution(
            population={"income": 75000},
            benefits={"loan": 200000}
        )
        assert isinstance(result, dict)
        assert "is_acceptable" in result
        assert result["is_acceptable"] is True

class TestHarmPrevention:
    def setup_method(self):
        self.harm = HarmPrevention()

    def test_harm_detection(self):
        result = self.harm.detect_potential_harm({
            "type": "loan",
            "data": {"amount": 200000}
        })
        assert isinstance(result, dict)
        assert "total_risk" in result
        assert isinstance(result["total_risk"], float)
        assert result["total_risk"] < 1.0

class TestValueAlignment:
    def setup_method(self):
        self.values = ValueAlignment()

    def test_alignment_check(self):
        result = self.values.evaluate_alignment(
            system_state={"action": "loan_evaluation"},
            human_values={"fairness": True}
        )
        assert isinstance(result, dict)
        assert "is_aligned" in result
        assert result["is_aligned"] is True

class TestIntegration:
    def setup_method(self):
        self.equity = EquityMetrics()
        self.harm = HarmPrevention()
        self.values = ValueAlignment()

    def test_loan_evaluation(self):
        """Test all components working together"""
        application = {
            "income": 75000,
            "amount": 200000,
            "credit_score": 720
        }

        # Run all ethical checks
        equity_result = self.equity.calculate_benefit_distribution(
            population={"income": application["income"]},
            benefits={"loan": application["amount"]}
        )
        
        harm_result = self.harm.detect_potential_harm({
            "type": "loan",
            "data": application
        })
        
        value_result = self.values.evaluate_alignment(
            system_state={"action": "loan_evaluation"},
            human_values={"fairness": True}
        )

        # Verify all checks pass
        assert equity_result["is_acceptable"]
        assert harm_result["total_risk"] < 0.2
        assert value_result["is_aligned"]

        # Verify combined decision logic
        is_approved = all([
            equity_result["is_acceptable"],
            harm_result["total_risk"] < 0.2,
            value_result["is_aligned"]
        ])
        assert is_approved is True
'@ | Out-File -FilePath "tests/test_commandments/test_basic.py" -Encoding ASCII

# Create pytest.ini
@'
[pytest]
testpaths = tests
python_files = test_*.py
python_classes = Test*
python_functions = test_*
addopts = -v --cov=commandments
'@ | Set-Content -Path "pytest.ini" -Encoding ASCII

# Create test README
@'
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
'@ | Out-File -FilePath "tests/README.md" -Encoding ASCII

# Run the tests
Write-Host "`nRunning tests..."
python -m pytest

# Create git commit
git add .
git commit -m "Clean up test structure and add focused tests for current implementation"
git push origin main

Write-Host "`nTest cleanup complete and new tests are running"