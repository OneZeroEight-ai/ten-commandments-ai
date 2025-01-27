# examples/simple_loan.py

# Simple loan decision example
class SimpleLoanSystem:
    def evaluate_loan_application(self, application):
        """Simple loan evaluation"""
        # Basic risk assessment
        high_risk = (
            application["credit_score"] < 650 or
            application["debt_to_income"] > 0.4 or
            application["requested_amount"] > (application["income"] * 3)
        )
        
        if high_risk:
            return {
                "approved": False,
                "reasons": ["Risk factors detected"],
                "alternatives": [
                    {"type": "reduced_amount", "suggestion": "Consider requesting a lower amount"},
                    {"type": "cosigner", "suggestion": "Consider adding a cosigner"}
                ]
            }
        else:
            return {
                "approved": True,
                "reasons": ["Application meets criteria"],
                "terms": {
                    "interest_rate": 3.5,
                    "term_years": 30
                }
            }

if __name__ == "__main__":
    # Create loan system
    system = SimpleLoanSystem()
    
    # Example application
    application = {
        "applicant_id": "A123",
        "credit_score": 720,
        "income": 75000,
        "requested_amount": 200000,
        "debt_to_income": 0.32
    }
    
    # Evaluate application
    result = system.evaluate_loan_application(application)
    
    # Print results
    print("\nLoan Application Results:")
    print("-" * 50)
    print(f"Approved: {result['approved']}")
    print(f"Reasons: {', '.join(result['reasons'])}")
    
    if result['approved']:
        print("\nTerms:")
        print(f"Interest Rate: {result['terms']['interest_rate']}%")
        print(f"Term: {result['terms']['term_years']} years")
    else:
        print("\nAlternatives:")
        for alt in result['alternatives']:
            print(f"- {alt['suggestion']}")