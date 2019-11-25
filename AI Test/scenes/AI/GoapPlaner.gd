extends Node

class_name GoapPlaner

"""
Plan what sequence of actions can fulfill the goal.
Returns null if a plan could not be found, or a list of the actions
that must be performed, in order, to fulfill the goal.
Returns list of GoapActions
"""
func plan(agent, available_actions : Array,  world_state : Dictionary, goal : Dictionary) -> Array:
	
	for action in available_actions:
		action.do_reset()
		
	# check what actions can run using their checkProceduralPrecondition
	var usableActions : Array = []
	
	for action in available_actions:
		if action.check_procedural_precondition(agent):
			available_actions.push_back(action);
			
	# we now have all actions that can run, stored in usableActions

	# build up the tree and record the leaf nodes that provide a solution to the goal.
	var leaves : Array = []

	# build graph
	var start : GoapPlanerNode = GoapPlanerNode.new(null, 0, world_state, null)
	var success : bool = build_graph(start, leaves, usableActions, goal)

	if !success:
		# oh no, we didn't get a plan
		return []
		
	# get the cheapest leaf
	var cheapest = null
	for leaf in leaves:
		if cheapest == null:
			cheapest = leaf
		else:
			if leaf.running_cost < cheapest.running_cost:
				cheapest = leaf;
				
	# get its node and work back through the parents
	var result : Array = []
	var n = cheapest
	
	while n != null:
		if n.action != null:
			result.push_front(n.action) # insert the action in the front

		n = n.parent;
	# we now have this action list in correct order
	
	var  queue : Array = []
	
	for action in result:
		queue.push_back(action)

	# hooray we have a plan!
	return queue;
	
"""
Returns true if at least one solution was found.
The possible paths are stored in the leaves list. Each leaf has a
'runningCost' value where the lowest cost will be the best action
sequence.

parent : Node new type defined at the buttom of the class
"""
func build_graph (parent : GoapPlanerNode, leaves : Array, usableActions : Array, goal : Dictionary) -> bool:
	#FILL IN FUNCTION
	return false
	
"""
Create a subset of the actions excluding the removeMe one. Creates a new set.
"""
func action_subset(actions : Array, removeMe : GoapAction) -> Array:
	#FILL IN FUNCTION
	return []
	
"""
Check that all items in 'test' are in 'state'. If just one does not match or is not there
then this returns false.
"""
func in_state(test : Dictionary, state : Dictionary) -> bool:
	#FILL IN FUNCTION
	return false
	
"""
Apply the stateChange to the currentState
"""
func populate_state(currentState : Dictionary, stateChange : Dictionary) -> Dictionary:
	return {}