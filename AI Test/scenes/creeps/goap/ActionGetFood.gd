extends "res://scenes/AI/GoapAction.gd"

var is_done : bool

func _ready():
	is_done = false
	add_effect("get_food", true)
	
func reset() -> void:
	is_done = false
	target = null
	in_range = false

func requires_in_range () -> bool:
	return true
	
func check_procedural_precondition(agent) -> bool: # agent : GameObject
	for food in get_tree().get_nodes_in_group("Food"):
		target = weakref(food)
		return true
		
	return false
	
func perform(agent) -> bool:  # agent : GameObject
	is_done = true
	return true
		
	
func is_done() -> bool:
	return is_done