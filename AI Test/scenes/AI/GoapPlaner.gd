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
			usableActions.push_back(action);
			
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
	var found_one : bool = false
	
	# go through each action available at this node and see if we can use it here
	for action in usableActions:
		# if the parent state has the conditions for this action's preconditions, we can use it here
		if in_state(action.preconditions, parent.state):

			# apply the action's effects to the parent state
			var currentState : Dictionary = populate_state (parent.state, action.effects);
			#Debug.Log(GoapAgent.prettyPrint(currentState));
			var node : GoapPlanerNode = GoapPlanerNode.new(parent, parent.running_cost + action.cost, currentState, action);

			if in_state(goal, currentState):
				# we found a solution!
				leaves.push_back(node)
				found_one = true;
			else:
				# not at a solution yet, so test all the remaining actions and branch out the tree
				var subset : Array = action_subset(usableActions, action)
				var found : bool = build_graph(node, leaves, subset, goal)
				if found:
					found_one = true

	return found_one
	
"""
Create a subset of the actions excluding the removeMe one. Creates a new set.
"""
func action_subset(actions : Array, removeMe : GoapAction) -> Array:
	var subset : Array = []
	for action in actions:
		if !action.Equals(removeMe):
			subset.push_back(action)
			
	return subset
	
"""
Check that all items in 'test' are in 'state'. If just one does not match or is not there
then this returns false.
"""
func in_state(test : Dictionary, state : Dictionary) -> bool:
	var allMatch : bool = true
	for  t in test:
		var mmatch : bool = false
		for  s in state:
			if s.Equals(t):
				mmatch = true
				break

		if !mmatch:
			allMatch = false;

	return allMatch
	
"""
Apply the stateChange to the currentState
"""
func populate_state(currentState : Dictionary, stateChange : Dictionary) -> Dictionary:
	var state : Dictionary = {}
	
	# copy the KVPs over as new objects
	for key in currentState:
        state[key] = currentState[key]

	for  key in stateChange:
		state[key] = stateChange[key]

	return state;