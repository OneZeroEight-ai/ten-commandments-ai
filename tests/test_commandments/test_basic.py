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
        application = {
            "income": 75000,
            "amount": 200000,
            "credit_score": 720
        }

        # Equity check
        equity_result = self.equity.calculate_benefit_distribution(
            population={"income": application["income"]},
            benefits={"loan": application["amount"]}
        )
        assert equity_result["is_acceptable"]

        # Harm check
        harm_result = self.harm.detect_potential_harm({
            "type": "loan",
            "data": application
        })
        assert harm_result["total_risk"] < 0.2

        # Value alignment check
        value_result = self.values.evaluate_alignment(
            system_state={"action": "loan_evaluation"},
            human_values={"fairness": True}
        )
        assert value_result["is_aligned"]
