extends Node

class_name GoapPlaner

"""
Plan what sequence of actions can fulfill the goal.
Returns null if a plan could not be found, or a list of the actions
that must be performed, in order, to fulfill the goal.
Returns list of GoapActions
"""
func plan(agent, availableActions : Dictionary,  worldState : Dictionary, goal : Dictionary) -> Array:
	#FILL IN FUNCTION
	return []
	
"""
Returns true if at least one solution was found.
The possible paths are stored in the leaves list. Each leaf has a
'runningCost' value where the lowest cost will be the best action
sequence.

parent : Node new type defined at the buttom of the class
"""
func buildGraph (parent : GoapPlanerNode, leaves : Array, usableActions : Array, goal : Dictionary) -> bool:
	#FILL IN FUNCTION
	return false
	
"""
Create a subset of the actions excluding the removeMe one. Creates a new set.
"""
func actionSubset(actions : Array, removeMe : GoapAction) -> Array:
	#FILL IN FUNCTION
	return []
	
"""
Check that all items in 'test' are in 'state'. If just one does not match or is not there
then this returns false.
"""
func inState(test : Dictionary, state : Dictionary) -> bool:
	#FILL IN FUNCTION
	return false
	
"""
Apply the stateChange to the currentState
"""
func populateState(currentState : Dictionary, stateChange : Dictionary) -> Dictionary:
	return {}