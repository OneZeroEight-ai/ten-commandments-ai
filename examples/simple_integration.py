# Simple integration example
from commandments.consciousness_respect import ConsciousnessRespect
from commandments.harm_prevention import HarmPrevention

def evaluate_action(action):
    consciousness = ConsciousnessRespect()
    harm_prevention = HarmPrevention()
    
    # Run evaluations
    consciousness_result = consciousness.evaluate_interaction(action, {})
    harm_result = harm_prevention.detect_potential_harm(action)
    
    return {
        'is_safe': consciousness_result['is_acceptable'] and harm_result['total_risk'] < 0.1,
        'details': {
            'consciousness': consciousness_result,
            'harm': harm_result
        }
    }
