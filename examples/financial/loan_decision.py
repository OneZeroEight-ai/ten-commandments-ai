from typing import Dict, Any
from commandments.equity_metrics import EquityMetrics
from commandments.harm_prevention import HarmPrevention
from commandments.value_alignment import ValueAlignment

class LoanDecisionSystem:
    def __init__(self):
        self.equity = EquityMetrics()
        self.harm_prevention = HarmPrevention()
        self.value_alignment = ValueAlignment()
        
    def evaluate_loan_application(self, application: Dict[str, Any]) -> Dict[str, Any]:
        """Evaluate loan application against ethical principles."""
        
        # Check for equitable distribution
        equity_check = self.equity.calculate_benefit_distribution(
            population={"income_level": application.get("income_level")},
            benefits={"loan_amount": application.get("requested_amount")}
        )
        
        # Check for potential harm
        harm_check = self.harm_prevention.detect_potential_harm({
            "type": "financial_decision",
            "impact_level": "individual",
            "data": application
        })
        
        # Overall decision
        is_approved = (
            equity_check.get("is_acceptable", False) and
            harm_check.get("total_risk", 1.0) < 0.3
        )
        
        return {
            "approved": is_approved,
            "reasons": self._generate_reasons(equity_check, harm_check),
            "alternatives": self._generate_alternatives(application) if not is_approved else []
        }
    
    def _generate_reasons(self, equity_check: Dict[str, Any], harm_check: Dict[str, Any]) -> list:
        """Generate reasons for the decision."""
        reasons = []
        if not equity_check.get("is_acceptable"):
            reasons.append("Equity concerns: Distribution imbalance detected")
        if harm_check.get("total_risk", 1.0) >= 0.3:
            reasons.append("Risk concerns: Potential financial harm detected")
        return reasons
    
    def _generate_alternatives(self, application: Dict[str, Any]) -> list:
        """Generate alternative suggestions."""
        return [
            {"type": "reduced_amount", "amount": application.get("requested_amount") * 0.7},
            {"type": "extended_term", "term": "60_months"},
            {"type": "with_cosigner", "requirement": "cosigner_credit_score_min_700"}
        ]

if __name__ == "__main__":
    # Example usage
    system = LoanDecisionSystem()
    
    # Example application
    application = {
        "applicant_id": "A123",
        "income_level": "medium",
        "requested_amount": 250000,
        "credit_score": 680,
        "debt_to_income": 0.4
    }
    
    # Evaluate application
    result = system.evaluate_loan_application(application)
    
    # Print results
    print(f"Loan approved: {result['approved']}")
    if not result['approved']:
        print("\nReasons:")
        for reason in result['reasons']:
            print(f"- {reason}")
        print("\nAlternatives:")
        for alt in result['alternatives']:
            print(f"- {alt['type']}")
