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
