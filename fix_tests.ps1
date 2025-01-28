# fix_tests.ps1

# Create correct pytest.ini without BOM marker
$pytestContent = @"
[pytest]
testpaths = tests
python_files = test_*.py
python_classes = Test
python_functions = test_*
addopts = -v --cov=commandments
"@

# Write content as ASCII (no BOM)
$pytestContent | Set-Content -Path "pytest.ini" -Encoding ASCII

# Run the tests again
Write-Host "Running tests with fixed configuration..."
python -m pytest

# Commit the fix
git add pytest.ini
git commit -m "Fix pytest.ini encoding"
git push origin main

Write-Host "Test configuration has been fixed and tests re-run"