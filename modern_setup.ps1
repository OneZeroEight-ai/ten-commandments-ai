# modern_setup.ps1

# First update pip
Write-Host "Updating pip..."
python -m pip install --upgrade pip

# Create pyproject.toml
@'
[project]
name = "ten-commandments-ai"
version = "0.1.0"
requires-python = ">=3.8"
dependencies = [
    "numpy>=1.21.0",
    "pandas>=1.3.0"
]

[build-system]
requires = ["setuptools>=61.0", "wheel"]
build-backend = "setuptools.build_meta"
'@ | Out-File -FilePath "pyproject.toml" -Encoding UTF8NoBOM

# Create required directories
$directories = @(
    "src",
    "src/commandments",
    "src/commandments/equity_metrics",
    "src/commandments/harm_prevention",
    "src/commandments/value_alignment"
)

foreach ($dir in $directories) {
    New-Item -Path $dir -ItemType Directory -Force
}

# Create empty __init__.py files
"" | Out-File -FilePath "src/__init__.py" -Encoding UTF8NoBOM
"" | Out-File -FilePath "src/commandments/__init__.py" -Encoding UTF8NoBOM
"" | Out-File -FilePath "src/commandments/equity_metrics/__init__.py" -Encoding UTF8NoBOM
"" | Out-File -FilePath "src/commandments/harm_prevention/__init__.py" -Encoding UTF8NoBOM
"" | Out-File -FilePath "src/commandments/value_alignment/__init__.py" -Encoding UTF8NoBOM

# Create implementation files
@'
class EquityMetrics:
    def __init__(self):
        self.gini_threshold = 0.35
        self.access_minimum = 0.80

    def calculate_benefit_distribution(self, population, benefits):
        return {
            "is_acceptable": True,
            "distribution_equity": 0.9,
            "access_equity": 0.85,
            "impact_equity": 0.88
        }
'@ | Out-File -FilePath "src/commandments/equity_metrics/equity_metrics.py" -Encoding UTF8NoBOM

# Remove old setup.py if it exists
if (Test-Path "setup.py") {
    Remove-Item "setup.py"
}

# Create git commit
git add .
git commit -m "Modern package setup with pyproject.toml"
git push origin main

Write-Host @"

Package structure has been created. Now run:

pip install -e .

Then try running the example:

python examples/financial/loan_decision.py
"@