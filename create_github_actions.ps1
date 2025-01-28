# create_github_actions.ps1

# Create GitHub Actions directory
New-Item -Path ".github/workflows" -ItemType Directory -Force

# Create main workflow file
@'
name: Python Tests

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: ["3.8", "3.9", "3.10"]

    steps:
    - uses: actions/checkout@v4
    - name: Set up Python ${{ matrix.python-version }}
      uses: actions/setup-python@v4
      with:
        python-version: ${{ matrix.python-version }}
    
    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install pytest pytest-cov
        pip install -e .
    
    - name: Run tests with coverage
      run: |
        pytest --cov=commandments --cov-report=xml
    
    - name: Upload coverage to Codecov
      uses: codecov/codecov-action@v3
      with:
        file: ./coverage.xml
        fail_ci_if_error: true
'@ | Out-File -FilePath ".github/workflows/python-tests.yml" -Encoding ASCII

# Create style check workflow
@'
name: Code Style

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  style:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v4
    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: "3.10"
    
    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install black flake8
    
    - name: Check style with black
      run: black --check .
    
    - name: Lint with flake8
      run: flake8 . --count --show-source --statistics
'@ | Out-File -FilePath ".github/workflows/code-style.yml" -Encoding ASCII

# Create documentation check workflow
@'
name: Documentation

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  docs:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v4
    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: "3.10"
    
    - name: Check markdown links
      uses: gaurav-nelson/github-action-markdown-link-check@v1
    
    - name: Verify documentation structure
      run: |
        test -f README.md
        test -d docs
        test -f CONTRIBUTING.md
        test -f CONTRIBUTORS.md
'@ | Out-File -FilePath ".github/workflows/documentation.yml" -Encoding ASCII

# Create dev dependencies for style checking
@'
[tool.black]
line-length = 88
include = '\.pyi?$'
exclude = '''
/(
    \.git
  | \.hg
  | \.mypy_cache
  | \.tox
  | \.venv
  | _build
  | buck-out
  | build
  | dist
)/
'''

[tool.flake8]
max-line-length = 88
extend-ignore = "E203"
'@ | Out-File -FilePath "pyproject.toml" -Encoding ASCII

# Create README badge section
$badgeContent = @'

## Status
[![Python Tests](https://github.com/OneZeroEight-ai/ten-commandments-ai/actions/workflows/python-tests.yml/badge.svg)](https://github.com/OneZeroEight-ai/ten-commandments-ai/actions/workflows/python-tests.yml)
[![Code Style](https://github.com/OneZeroEight-ai/ten-commandments-ai/actions/workflows/code-style.yml/badge.svg)](https://github.com/OneZeroEight-ai/ten-commandments-ai/actions/workflows/code-style.yml)
[![Documentation](https://github.com/OneZeroEight-ai/ten-commandments-ai/actions/workflows/documentation.yml/badge.svg)](https://github.com/OneZeroEight-ai/ten-commandments-ai/actions/workflows/documentation.yml)

'@

# Update README with badges
(Get-Content README.md) | 
    ForEach-Object {$_ -replace "^# Ten Commandments for AI", "# Ten Commandments for AI`n$badgeContent"} | 
    Set-Content README.md

# Install dev dependencies
pip install black flake8

# Create git commit
git add .
git commit -m "Add GitHub Actions workflows for testing, style, and documentation"
git push origin main

Write-Host "GitHub Actions have been set up in the repository"