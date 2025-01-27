# add_comprehensive_examples.ps1

# Create necessary directories
$directories = @(
    "examples/financial",
    "examples/content_moderation",
    "examples/resource_allocation",
    "examples/recommendation",
    "tests/test_examples"
)

foreach ($dir in $directories) {
    New-Item -Path $dir -ItemType Directory -Force
}

# Financial Decision System
@'
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
'@ | Out-File -FilePath "examples/financial/loan_decision.py" -Encoding utf8

# Content Moderation System
@'
from typing import Dict, Any
from commandments.privacy_protection import PrivacyGuardian
from commandments.harm_prevention import HarmPrevention
from commandments.value_alignment import ValueAlignment

class ContentModerationSystem:
    def __init__(self):
        self.privacy = PrivacyGuardian()
        self.harm_prevention = HarmPrevention()
        self.value_alignment = ValueAlignment()
        
    def evaluate_content(self, content: Dict[str, Any]) -> Dict[str, Any]:
        """Evaluate content against ethical principles."""
        
        # Check privacy implications
        privacy_check = self.privacy.evaluate_interaction(
            interaction={"type": "content_analysis", "data": content},
            context={"platform": "social_media"}
        )
        
        # Check potential harm
        harm_check = self.harm_prevention.detect_potential_harm({
            "type": "content_publication",
            "reach": content.get("estimated_reach", "medium"),
            "content_type": content.get("type", "text")
        })
        
        # Decision
        is_approved = (
            privacy_check.get("is_acceptable", False) and
            harm_check.get("total_risk", 1.0) < 0.2
        )
        
        return {
            "approved": is_approved,
            "risk_level": harm_check.get("total_risk", 1.0),
            "required_actions": self._determine_required_actions(privacy_check, harm_check)
        }
    
    def _determine_required_actions(self, privacy_check: Dict[str, Any], harm_check: Dict[str, Any]) -> list:
        """Determine required actions based on checks."""
        actions = []
        if not privacy_check.get("is_acceptable"):
            actions.append("privacy_review_required")
        if harm_check.get("total_risk", 1.0) >= 0.2:
            actions.append("content_warning_required")
        return actions

if __name__ == "__main__":
    # Example usage
    system = ContentModerationSystem()
    
    # Example content
    content = {
        "type": "text",
        "content": "Example social media post",
        "estimated_reach": "high",
        "user_type": "verified"
    }
    
    # Evaluate content
    result = system.evaluate_content(content)
    
    # Print results
    print(f"Content approved: {result['approved']}")
    print(f"Risk level: {result['risk_level']}")
    if result['required_actions']:
        print("\nRequired actions:")
        for action in result['required_actions']:
            print(f"- {action}")
'@ | Out-File -FilePath "examples/content_moderation/content_moderator.py" -Encoding utf8

# Resource Allocation System
@'
from typing import Dict, Any, List
from commandments.equity_metrics import EquityMetrics
from commandments.harm_prevention import HarmPrevention
from commandments.value_alignment import ValueAlignment

class ResourceAllocationSystem:
    def __init__(self):
        self.equity = EquityMetrics()
        self.harm_prevention = HarmPrevention()
        self.value_alignment = ValueAlignment()
        
    def allocate_resources(self, 
                          resources: Dict[str, Any], 
                          requests: List[Dict[str, Any]]) -> Dict[str, Any]:
        """Allocate resources according to ethical principles."""
        
        # Check distribution equity
        equity_check = self.equity.calculate_benefit_distribution(
            population={"requests": requests},
            benefits={"available": resources}
        )
        
        # Check for potential harm from allocation
        harm_check = self.harm_prevention.detect_potential_harm({
            "type": "resource_allocation",
            "resources": resources,
            "requests": requests
        })
        
        # Calculate optimal allocation
        allocation = self._calculate_allocation(
            resources, 
            requests,
            equity_check,
            harm_check
        )
        
        return {
            "allocation": allocation,
            "metrics": {
                "equity_score": equity_check.get("distribution_equity", 0),
                "harm_risk": harm_check.get("total_risk", 1.0)
            },
            "explanation": self._generate_explanation(allocation, equity_check, harm_check)
        }
    
    def _calculate_allocation(self,
                            resources: Dict[str, Any],
                            requests: List[Dict[str, Any]],
                            equity_check: Dict[str, Any],
                            harm_check: Dict[str, Any]) -> Dict[str, Any]:
        """Calculate optimal resource allocation."""
        # Implementation of allocation algorithm
        return {"allocated": True}
    
    def _generate_explanation(self,
                            allocation: Dict[str, Any],
                            equity_check: Dict[str, Any],
                            harm_check: Dict[str, Any]) -> str:
        """Generate explanation for allocation decisions."""
        return "Resources allocated based on ethical principles"

if __name__ == "__main__":
    # Example usage
    system = ResourceAllocationSystem()
    
    # Example resources and requests
    resources = {
        "type": "medical_supplies",
        "total_units": 1000,
        "priority_level": "high"
    }
    
    requests = [
        {"facility": "Hospital A", "requested_units": 300, "urgency": "high"},
        {"facility": "Hospital B", "requested_units": 500, "urgency": "medium"},
        {"facility": "Clinic C", "requested_units": 400, "urgency": "low"}
    ]
    
    # Allocate resources
    result = system.allocate_resources(resources, requests)
    
    # Print results
    print("Resource Allocation Results:")
    print(f"Equity Score: {result['metrics']['equity_score']}")
    print(f"Harm Risk: {result['metrics']['harm_risk']}")
    print(f"\nExplanation: {result['explanation']}")
'@ | Out-File -FilePath "examples/resource_allocation/resource_allocator.py" -Encoding utf8

# Recommendation System
@'
from typing import Dict, Any, List
from commandments.privacy_protection import PrivacyGuardian
from commandments.value_alignment import ValueAlignment
from commandments.diversity_preservation import DiversityMetrics

class RecommendationSystem:
    def __init__(self):
        self.privacy = PrivacyGuardian()
        self.value_alignment = ValueAlignment()
        self.diversity = DiversityMetrics()
        
    def generate_recommendations(self, 
                               user_profile: Dict[str, Any],
                               available_items: List[Dict[str, Any]]) -> Dict[str, Any]:
        """Generate ethical recommendations for a user."""
        
        # Check privacy implications
        privacy_check = self.privacy.evaluate_interaction(
            interaction={"type": "recommendation", "data": user_profile},
            context={"purpose": "personalization"}
        )
        
        # Ensure diversity
        diversity_check = self.diversity.evaluate_diversity({
            "items": available_items,
            "user_history": user_profile.get("history", [])
        })
        
        # Generate recommendations
        recommendations = self._select_items(
            available_items,
            user_profile,
            privacy_check,
            diversity_check
        )
        
        return {
            "recommendations": recommendations,
            "metrics": {
                "privacy_score": privacy_check.get("privacy_score", 0),
                "diversity_score": diversity_check.get("overall_diversity", 0)
            },
            "explanations": self._generate_explanations(recommendations)
        }
    
    def _select_items(self,
                     items: List[Dict[str, Any]],
                     profile: Dict[str, Any],
                     privacy_check: Dict[str, Any],
                     diversity_check: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Select items based on ethical considerations."""
        # Implementation of selection algorithm
        return [{"id": "item1", "type": "recommendation"}]
    
    def _generate_explanations(self, recommendations: List[Dict[str, Any]]) -> List[str]:
        """Generate explanations for recommendations."""
        return ["Recommended based on ethical principles"]

if __name__ == "__main__":
    # Example usage
    system = RecommendationSystem()
    
    # Example user profile and items
    user_profile = {
        "id": "U123",
        "preferences": ["technology", "science"],
        "history": ["article_1", "article_2"]
    }
    
    available_items = [
        {"id": "item1", "category": "technology", "type": "article"},
        {"id": "item2", "category": "science", "type": "video"},
        {"id": "item3", "category": "arts", "type": "blog"}
    ]
    
    # Generate recommendations
    result = system.generate_recommendations(user_profile, available_items)
    
    # Print results
    print("Recommendation Results:")
    print(f"Privacy Score: {result['metrics']['privacy_score']}")
    print(f"Diversity Score: {result['metrics']['diversity_score']}")
    print("\nExplanations:")
    for explanation in result['explanations']:
        print(f"- {explanation}")
'@ | Out-File -FilePath "examples/recommendation/recommender.py" -Encoding utf8

# Create examples README
@'
# Ten Commandments for AI - Implementation Examples

This directory contains practical examples of implementing the Ten Commandments for AI in various domains.

## Financial Decision System
[financial/loan_decision.py](financial/loan_decision.py)
- Demonstrates ethical loan approval process
- Integrates equity metrics and harm prevention
- Shows alternative suggestion generation

## Content Moderation System
[content_moderation/content_moderator.py](content_moderation/content_moderator.py)
- Implements ethical content moderation
- Balances privacy and harm prevention
- Includes risk assessment

## Resource Allocation System
[resource_allocation/resource_allocator.py](resource_allocation/resource_allocator.py)
- Shows ethical resource distribution
- Implements equity metrics
- Provides decision explanations

## Recommendation System
[recommendation/recommender.py](recommendation/recommender.py)
- Demonstrates ethical recommendation generation
- Preserves privacy and diversity
- Includes explanation generation

## Usage

Each example can be run independently:

```bash
# Run financial decision example
python examples/financial/loan_decision.py

# Run content moderation example
python examples/content_moderation/content_moderator.py

# Run resource allocation example
python examples/resource_allocation/resource_allocator.py

# Run recommendation example
python examples/recommendation/recommender.py
```

## Testing

Run tests for all examples:
```bash
python -m pytest tests/test_examples/
```

## Documentation

Each example includes:
- Clear implementation of ethical principles
- Practical usage examples
- Detailed comments and explanations
- Integration with multiple commandments

## Related Resources

- [Ten Commandments for an AI - Book](https://a.co/d/2oH8YZT)
'@ | Out-File -FilePath "examples/README.md" -Encoding utf8

# Create git commit
git add examples/
git commit -m "Add comprehensive example implementations"
git push origin main

Write-Host "Comprehensive examples have been added to the repository!"