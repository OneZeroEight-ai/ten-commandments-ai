﻿# Ten Commandments for AI

An implementation of ethical principles and guidelines for artificial intelligence systems, based on the [Ten Commandments for an AI](https://a.co/d/2oH8YZT) book.

## Overview

This repository implements ethical AI principles through a practical Python package. The implementation provides tools for evaluating AI decisions against key ethical criteria:

- Equity and fairness
- Harm prevention
- Value alignment

## Installation

```bash
git clone https://github.com/OneZeroEight-ai/ten-commandments-ai.git
cd ten-commandments-ai
pip install -e .
```

## Quick Start

Here\'s a simple example using the ethical evaluation system:

```python
from commandments import EquityMetrics, HarmPrevention, ValueAlignment

# Create ethical evaluation components
equity = EquityMetrics()
harm = HarmPrevention()
values = ValueAlignment()

# Example: Evaluate a loan decision
application = {
    "income": 75000,
    "amount": 200000,
    "credit_score": 720
}

# Check equity
equity_result = equity.calculate_benefit_distribution(
    population={"income": application["income"]},
    benefits={"loan": application["amount"]}
)

# Check potential harm
harm_result = harm.detect_potential_harm(
    situation={"type": "loan", "data": application}
)

# Check value alignment
value_result = values.evaluate_alignment(
    system_state={"action": "loan_evaluation"},
    human_values={"fairness": True}
)

# Combined ethical evaluation
is_ethical = all([
    equity_result["is_acceptable"],
    harm_result["total_risk"] < 0.2,
    value_result["is_aligned"]
])
```

## Examples

See the `examples` directory for complete working examples:

- `simple_loan.py` - Basic loan decision system
- `smart_loan.py` - Loan system with ethical evaluations

## Documentation

### Core Components

#### EquityMetrics
Evaluates fairness and equitable distribution of benefits:
```python
equity = EquityMetrics()
result = equity.calculate_benefit_distribution(population, benefits)
```

#### HarmPrevention
Assesses and prevents potential harms:
```python
harm = HarmPrevention()
result = harm.detect_potential_harm(situation)
```

#### ValueAlignment
Ensures alignment with human values:
```python
values = ValueAlignment()
result = values.evaluate_alignment(system_state, human_values)
```

### Project Structure

```
ten-commandments-ai/
â”œâ”€â”€ commandments/          # Main package
â”‚   â””â”€â”€ __init__.py       # Core implementations
â”œâ”€â”€ examples/             # Example implementations
â”‚   â”œâ”€â”€ simple_loan.py   # Basic example
â”‚   â””â”€â”€ smart_loan.py    # Advanced example
â””â”€â”€ setup.py             # Package setup file
```

## Related Resources

- [Ten Commandments for an AI - Book](https://a.co/d/2oH8YZT)
- [Implementation Source Code](https://github.com/OneZeroEight-ai/ten-commandments-ai)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
