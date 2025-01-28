# create_contribution_guide.ps1

# Create docs/contributing directory
New-Item -Path "docs/contributing" -ItemType Directory -Force

# Create main CONTRIBUTING.md file
@'
# Contributing to Ten Commandments for AI

Thank you for your interest in contributing to the Ten Commandments for AI project! This document provides guidelines for contributing.

## Table of Contents
- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Process](#development-process)
- [Code Standards](#code-standards)
- [Testing Requirements](#testing-requirements)
- [Documentation Standards](#documentation-standards)
- [Pull Request Process](#pull-request-process)

## Code of Conduct

Our project adheres to a code of conduct that all contributors must follow:
- Be respectful and inclusive
- Focus on the principles from the [Ten Commandments for an AI book](https://a.co/d/2oH8YZT)
- Maintain ethical considerations in all contributions
- Provide constructive feedback
- Help maintain project quality

## Getting Started

1. Fork the repository
2. Clone your fork:
```bash
git clone https://github.com/YOUR-USERNAME/ten-commandments-ai.git
cd ten-commandments-ai
```

3. Install dependencies:
```bash
pip install -e .
pip install pytest pytest-cov
```

4. Create a branch for your work:
```bash
git checkout -b feature/your-feature-name
```

## Development Process

1. Check existing issues and discussions
2. Create an issue for new features
3. Write code following our standards
4. Add tests for new functionality
5. Update documentation
6. Submit a pull request

## Code Standards

### Python Style
- Follow PEP 8
- Use type hints
- Include docstrings for all classes and methods
- Keep functions focused and modular

Example:
```python
from typing import Dict, Any

def evaluate_ethics(action: Dict[str, Any]) -> Dict[str, Any]:
    """
    Evaluate ethical implications of an action.
    
    Args:
        action: Dictionary containing action details
        
    Returns:
        Dictionary containing ethical evaluation results
    """
    # Implementation
    pass
```

### Project Structure
```
ten-commandments-ai/
├── commandments/          # Core package
├── docs/                 # Documentation
├── examples/             # Example implementations
├── tests/               # Test suite
└── README.md           # Main documentation
```

## Testing Requirements

All contributions must:
1. Include unit tests
2. Maintain 100% test coverage
3. Pass all existing tests
4. Include integration tests where appropriate

Example test:
```python
def test_ethical_evaluation():
    """Test basic ethical evaluation functionality"""
    evaluator = EthicalEvaluator()
    result = evaluator.evaluate({"action": "test"})
    assert result["is_ethical"] is True
```

## Documentation Standards

1. Code Documentation
   - Clear docstrings
   - Type hints
   - Inline comments for complex logic
   - Example usage

2. Project Documentation
   - Update README if needed
   - Add feature documentation
   - Include example usage
   - Update test documentation

Example docstring:
```python
def calculate_fairness(distribution: Dict[str, float]) -> float:
    """
    Calculate fairness score for a resource distribution.
    
    Args:
        distribution: Dictionary mapping recipients to resource amounts
        
    Returns:
        Float between 0 and 1 representing fairness score
        
    Example:
        >>> calculate_fairness({"A": 0.5, "B": 0.5})
        1.0
    """
```

## Pull Request Process

1. Create Feature Branch
```bash
git checkout -b feature/your-feature
```

2. Make Changes
   - Write code
   - Add tests
   - Update docs

3. Run Tests
```bash
python -m pytest
```

4. Create Pull Request
   - Clear description
   - Reference issues
   - List changes
   - Include test results

5. PR Template:
```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Other (please specify)

## Testing
- [ ] New tests added
- [ ] All tests passing
- [ ] 100% coverage maintained

## Related Issues
Fixes #(issue)
```

## Review Process

1. Code Review
   - Style compliance
   - Test coverage
   - Documentation quality
   - Ethical considerations

2. Automated Checks
   - Tests pass
   - Coverage maintained
   - Style requirements met

3. Review Response
   - Address feedback
   - Update as needed
   - Maintain communication

## Questions and Support

- Open an issue for questions
- Join discussions
- Check documentation first
- Be specific in questions

## Recognition

Contributors will be:
- Listed in CONTRIBUTORS.md
- Credited in release notes
- Recognized in documentation
'@ | Out-File -FilePath "CONTRIBUTING.md" -Encoding ASCII

# Create CONTRIBUTORS.md
@'
# Contributors

Thank you to all who have contributed to this project!

## Core Team
- [OneZeroEight-ai](https://github.com/OneZeroEight-ai)

## Contributors
<!-- Add contributors here -->

## How to Contribute
See our [Contributing Guide](CONTRIBUTING.md) for details on how to contribute to this project.

## Recognition
All contributors will be listed here and recognized in release notes.
'@ | Out-File -FilePath "CONTRIBUTORS.md" -Encoding ASCII

# Update main README to reference contribution guidelines
$readmeContent = Get-Content "README.md"
$newContent = @'

## Contributing

We welcome contributions! Please see:
- [Contributing Guidelines](CONTRIBUTING.md)
- [Contributors](CONTRIBUTORS.md)
'@

Add-Content -Path "README.md" -Value $newContent

# Create git commit
git add .
git commit -m "Add comprehensive contribution guidelines and recognition"
git push origin main

Write-Host "Contribution guidelines have been added to the repository"