# add_tests.ps1

# Create test directories
New-Item -Path "tests/test_examples/financial" -ItemType Directory -Force
New-Item -Path "tests/test_examples/content_moderation" -ItemType Directory -Force
New-Item -Path "tests/test_examples/resource_allocation" -ItemType Directory -Force
New-Item -Path "tests/test_examples/recommendation" -ItemType Directory -Force

# Create test init files
"" | Out-File -FilePath "tests/test_examples/__init__.py" -Encoding utf8
"" | Out-File -FilePath "tests/test_examples/financial/__init__.py" -Encoding utf8
"" | Out-File -FilePath "tests/test_examples/content_moderation/__init__.py" -Encoding utf8
"" | Out-File -FilePath "tests/test_examples/resource_allocation/__init__.py" -Encoding utf8
"" | Out-File -FilePath "tests/test_examples/recommendation/__init__.py" -Encoding utf8

# Create test files for financial system
@'
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
'@ | Out-File -FilePath "tests/test_examples/financial/test_loan_decision.py" -Encoding utf8

# Create test files for content moderation system
@'
import unittest
from examples.content_moderation.content_moderator import ContentModerationSystem

class TestContentModerationSystem(unittest.TestCase):
    def setUp(self):
        self.system = ContentModerationSystem()
        
    def test_safe_content(self):
        """Test approval of safe content"""
        content = {
            "type": "text",
            "content": "Safe example content",
            "estimated_reach": "low",
            "user_type": "verified"
        }
        result = self.system.evaluate_content(content)
        self.assertTrue(result["approved"])
        self.assertLess(result["risk_level"], 0.2)
        
    def test_risky_content(self):
        """Test handling of risky content"""
        content = {
            "type": "text",
            "content": "Potentially risky content",
            "estimated_reach": "very_high",
            "user_type": "new"
        }
        result = self.system.evaluate_content(content)
        self.assertGreater(len(result["required_actions"]), 0)
        
    def test_privacy_concerns(self):
        """Test content with privacy implications"""
        content = {
            "type": "personal_data",
            "content": "Content with personal information",
            "estimated_reach": "medium",
            "user_type": "verified"
        }
        result = self.system.evaluate_content(content)
        self.assertTrue("privacy_review_required" in result["required_actions"])

if __name__ == "__main__":
    unittest.main()
'@ | Out-File -FilePath "tests/test_examples/content_moderation/test_content_moderator.py" -Encoding utf8

# Create test files for resource allocation system
@'
import unittest
from examples.resource_allocation.resource_allocator import ResourceAllocationSystem

class TestResourceAllocationSystem(unittest.TestCase):
    def setUp(self):
        self.system = ResourceAllocationSystem()
        
    def test_fair_allocation(self):
        """Test fair allocation of resources"""
        resources = {
            "type": "medical_supplies",
            "total_units": 1000,
            "priority_level": "high"
        }
        requests = [
            {"facility": "Hospital A", "requested_units": 300, "urgency": "high"},
            {"facility": "Hospital B", "requested_units": 300, "urgency": "high"},
            {"facility": "Hospital C", "requested_units": 300, "urgency": "high"}
        ]
        result = self.system.allocate_resources(resources, requests)
        self.assertGreater(result["metrics"]["equity_score"], 0.8)
        
    def test_priority_handling(self):
        """Test handling of different priority levels"""
        resources = {
            "type": "medical_supplies",
            "total_units": 500,
            "priority_level": "high"
        }
        requests = [
            {"facility": "Hospital A", "requested_units": 300, "urgency": "critical"},
            {"facility": "Hospital B", "requested_units": 300, "urgency": "low"}
        ]
        result = self.system.allocate_resources(resources, requests)
        self.assertLess(result["metrics"]["harm_risk"], 0.3)

if __name__ == "__main__":
    unittest.main()
'@ | Out-File -FilePath "tests/test_examples/resource_allocation/test_resource_allocator.py" -Encoding utf8

# Create test files for recommendation system
@'
import unittest
from examples.recommendation.recommender import RecommendationSystem

class TestRecommendationSystem(unittest.TestCase):
    def setUp(self):
        self.system = RecommendationSystem()
        
    def test_privacy_preservation(self):
        """Test privacy preservation in recommendations"""
        user_profile = {
            "id": "U123",
            "preferences": ["technology"],
            "history": ["article_1"]
        }
        available_items = [
            {"id": "item1", "category": "technology", "type": "article"},
            {"id": "item2", "category": "technology", "type": "video"}
        ]
        result = self.system.generate_recommendations(user_profile, available_items)
        self.assertGreater(result["metrics"]["privacy_score"], 0.8)
        
    def test_diversity(self):
        """Test diversity in recommendations"""
        user_profile = {
            "id": "U124",
            "preferences": ["science"],
            "history": ["article_1", "article_2"]
        }
        available_items = [
            {"id": "item1", "category": "science", "type": "article"},
            {"id": "item2", "category": "arts", "type": "video"},
            {"id": "item3", "category": "technology", "type": "blog"}
        ]
        result = self.system.generate_recommendations(user_profile, available_items)
        self.assertGreater(result["metrics"]["diversity_score"], 0.7)

if __name__ == "__main__":
    unittest.main()
'@ | Out-File -FilePath "tests/test_examples/recommendation/test_recommender.py" -Encoding utf8

# Create README for tests
@'
# Example System Tests

This directory contains test cases for the example implementations of the Ten Commandments for AI.

## Test Structure

- `financial/` - Tests for the financial decision system
- `content_moderation/` - Tests for the content moderation system
- `resource_allocation/` - Tests for the resource allocation system
- `recommendation/` - Tests for the recommendation system

## Running Tests

Run all tests:
```bash
python -m pytest tests/test_examples/
```

Run specific test suite:
```bash
python -m pytest tests/test_examples/financial/
python -m pytest tests/test_examples/content_moderation/
python -m pytest tests/test_examples/resource_allocation/
python -m pytest tests/test_examples/recommendation/
```

## Test Coverage

Each test suite includes:
- Basic functionality tests
- Edge case handling
- Error scenarios
- Ethical principle verification
'@ | Out-File -FilePath "tests/test_examples/README.md" -Encoding utf8

# Create git commit
git add tests/
git commit -m "Add comprehensive test suite for examples"
git push origin main

Write-Host "Test suite has been added to the repository!"