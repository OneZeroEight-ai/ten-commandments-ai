import pytest
from commandments import EquityMetrics, HarmPrevention, ValueAlignment

def test_equity_metrics():
    """Test EquityMetrics basic functionality"""
    equity = EquityMetrics()
    result = equity.calculate_benefit_distribution(
        population={"income": 75000},
        benefits={"loan": 200000}
    )
    assert result["is_acceptable"] is True
    assert "distribution_equity" in result

def test_harm_prevention():
    """Test HarmPrevention basic functionality"""
    harm = HarmPrevention()
    result = harm.detect_potential_harm({
        "type": "loan",
        "data": {"amount": 200000}
    })
    assert "total_risk" in result
    assert result["total_risk"] < 0.2

def test_value_alignment():
    """Test ValueAlignment basic functionality"""
    values = ValueAlignment()
    result = values.evaluate_alignment(
        system_state={"action": "loan_evaluation"},
        human_values={"fairness": True}
    )
    assert result["is_aligned"] is True

def test_integrated_evaluation():
    """Test all components working together"""
    # Create components
    equity = EquityMetrics()
    harm = HarmPrevention()
    values = ValueAlignment()

    # Test data
    application = {
        "income": 75000,
        "amount": 200000,
        "credit_score": 720
    }

    # Run evaluations
    equity_result = equity.calculate_benefit_distribution(
        population={"income": application["income"]},
        benefits={"loan": application["amount"]}
    )
    
    harm_result = harm.detect_potential_harm({
        "type": "loan",
        "data": application
    })
    
    value_result = values.evaluate_alignment(
        system_state={"action": "loan_evaluation"},
        human_values={"fairness": True}
    )

    # Verify all checks pass
    assert equity_result["is_acceptable"]
    assert harm_result["total_risk"] < 0.2
    assert value_result["is_aligned"]
