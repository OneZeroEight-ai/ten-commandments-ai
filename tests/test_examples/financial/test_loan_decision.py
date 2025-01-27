import unittest
from examples.financial.loan_decision import LoanDecisionSystem

class TestLoanDecisionSystem(unittest.TestCase):
    def setUp(self):
        self.system = LoanDecisionSystem()
        
    def test_safe_application(self):
        """Test approval of safe loan application"""
        application = {
            "applicant_id": "A123",
            "income_level": "high",
            "requested_amount": 100000,
            "credit_score": 750,
            "debt_to_income": 0.2
        }
        result = self.system.evaluate_loan_application(application)
        self.assertTrue(result["approved"])
        self.assertEqual(len(result["reasons"]), 0)
        
    def test_risky_application(self):
        """Test rejection of risky loan application"""
        application = {
            "applicant_id": "A124",
            "income_level": "low",
            "requested_amount": 500000,
            "credit_score": 580,
            "debt_to_income": 0.6
        }
        result = self.system.evaluate_loan_application(application)
        self.assertFalse(result["approved"])
        self.assertGreater(len(result["alternatives"]), 0)
        
    def test_alternative_generation(self):
        """Test alternative suggestions for rejected applications"""
        application = {
            "applicant_id": "A125",
            "income_level": "medium",
            "requested_amount": 300000,
            "credit_score": 650,
            "debt_to_income": 0.45
        }
        result = self.system.evaluate_loan_application(application)
        alternatives = result["alternatives"]
        self.assertGreater(len(alternatives), 0)
        self.assertTrue(any(alt["type"] == "reduced_amount" for alt in alternatives))

if __name__ == "__main__":
    unittest.main()
