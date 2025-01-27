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
