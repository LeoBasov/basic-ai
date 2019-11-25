extends "res://scenes/AI/FiniteState.gd"

func update(object) -> void:
	var data_provider = object.get_node("GoapAgent/IGoap")
	var agent = object.get_node("GoapAgent")
	
	# get the world state and the goal we want to plan for
	var world_state = data_provider.get_world_state()
	var goal = data_provider.create_goal_state()
	var available_actions = object.get_node("GoapAgent").available_actions
	
	# Plan
	var plan = $GoapPlaner.plan(agent, available_actions, world_state, goal)
	
	if plan.size() != 0:
		# we have a plan, hooray!
		object.get_node("GoapAgent").current_actions = plan
		data_provider.plan_found(goal, plan)
		emit_signal("pop") #move to PerformAction state
		emit_signal("push", "PerformActionState")

	else:
		# ugh, we couldn't get a plan
		data_provider.plan_failed(goal)
		emit_signal("pop") # move back to IdleAction state
		emit_signal("push","IdleState")