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
