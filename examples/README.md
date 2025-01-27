# Examples

This directory contains practical examples of implementing ethical AI principles.

## Simple Loan System
[simple_loan.py](simple_loan.py)
- Basic implementation of a loan decision system
- Demonstrates fundamental decision-making principles
- Simple, self-contained example

## Smart Loan System with Ethical Evaluation
[smart_loan.py](smart_loan.py)
- Complete implementation using ethical evaluation components
- Demonstrates integration of:
  - Equity metrics
  - Harm prevention
  - Value alignment
- Shows practical application of ethical principles

## Running the Examples

```bash
# Run simple loan example
python examples/simple_loan.py

# Run smart loan example with ethical evaluation
python examples/smart_loan.py
```

## Output Example

The smart loan example will provide output like:

```
Ethical Loan Evaluation Results:
--------------------------------------------------
Approved: True
Ethical Checks:
- equity: {"is_acceptable": True}
- harm: {"total_risk": 0.1}
- values: {"is_aligned": True}
```

## Adding New Examples

When creating new examples:
1. Import required components from commandments package
2. Set up ethical evaluation checks
3. Provide clear output of ethical considerations
4. Add documentation explaining the example
