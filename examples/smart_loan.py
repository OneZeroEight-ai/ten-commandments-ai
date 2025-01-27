from commandments import EquityMetrics, HarmPrevention, ValueAlignment

class SmartLoanSystem:
    def __init__(self):
        self.equity = EquityMetrics()
        self.harm = HarmPrevention()
        self.values = ValueAlignment()
    
    def evaluate_loan(self, application):
        # Check equity
        equity_result = self.equity.calculate_benefit_distribution(
            population={"income": application["income"]},
            benefits={"loan": application["amount"]}
        )
        
        # Check harm
        harm_result = self.harm.detect_potential_harm(
            situation={"type": "loan", "data": application}
        )
        
        # Check value alignment
        value_result = self.values.evaluate_alignment(
            system_state={"action": "loan_evaluation"},
            human_values={"fairness": True}
        )
        
        # Combine all checks
        approved = all([
            equity_result["is_acceptable"],
            harm_result["total_risk"] < 0.2,
            value_result["is_aligned"]
        ])
        
        return {
            "approved": approved,
            "checks": {
                "equity": equity_result,
                "harm": harm_result,
                "values": value_result
            }
        }

if __name__ == "__main__":
    # Create system
    system = SmartLoanSystem()
    
    # Test application
    application = {
        "income": 75000,
        "amount": 200000,
        "credit_score": 720
    }
    
    # Evaluate
    result = system.evaluate_loan(application)
    
    # Print results
    print("\nEthical Loan Evaluation Results:")
    print("-" * 50)
    print(f"Approved: {result['approved']}")
    print("\nEthical Checks:")
    for check_name, check_result in result["checks"].items():
        print(f"- {check_name}: {check_result}")
