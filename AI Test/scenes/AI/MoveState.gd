extends "res://scenes/AI/FiniteState.gd"

func update(object):
	var data_provider = object.get_node("GoapAgent/IGoap")
	var current_actions = object.get_node("GoapAgent").current_actions
	
	var action : GoapAction = current_actions.back()
	
	if action.requires_in_range() and action.target == null:
		emit_signal("pop")
		emit_signal("pop")
		emit_signal("push", "IdleState")
		return
	
	if data_provider.move_agent(action):
		emit_signal("pop")