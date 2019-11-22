extends "res://scenes/AI/FiniteState.gd"

func update(object):	
	for food in get_tree().get_nodes_in_group("Food"):
		object.found_food = food
		break
		
	if object.found_food:
		emit_signal("pop_push", "StateGoto")