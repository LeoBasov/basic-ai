extends "res://scenes/AI/FiniteState.gd"

var data_provider : IGoap

func update(object) -> void:
	data_provider = object.get_node("GoapAgent/IGoap")
	
	# get the world state and the goal we want to plan for
	var world_state = data_provider.get_world_state()
	var goal = data_provider.create_goal_state()
	
	# Plan
	var plan = $GoapPlaner.plan(data_provider.game_object, object.get_node("GoapAgent").available_actions, world_state, goal)
	
	if plan.size() != 0:
		# we have a plan, hooray!
		object.get_node("GoapAgent").current_actions = plan
		data_provider.planFound(goal, plan)
		emit_signal("pop") #move to PerformAction state
		emit_signal("push", "PerformActionState")

	else:
		# ugh, we couldn't get a plan
		data_provider.plan_failed(goal)
		emit_signal("pop") # move back to IdleAction state
		emit_signal("push","IdleState")