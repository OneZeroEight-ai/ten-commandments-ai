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
