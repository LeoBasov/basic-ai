extends "res://scenes/AI/GoapAction.gd"

func _ready():
	add_effect("get_food", true)

func requires_in_range () -> bool:
	return true
	
func check_procedural_precondition(agent) -> bool: # agent : GameObject
	for food in get_tree().get_nodes_in_group("Food"):
		target = food
		return true
		
	return false