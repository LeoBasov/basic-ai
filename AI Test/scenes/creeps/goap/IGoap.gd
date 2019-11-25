extends "res://scenes/AI/IGoap.gd"

func get_world_state() -> Dictionary:
	var goal : Dictionary = {}
	
	goal["get_food"] = true
	
	return goal
	
func move_agent(next_action : GoapAction) -> bool:
	var vec = next_action.target.position - game_object.position
	var velocity = vec.normalized()*game_object.SPEED
	game_object.move_and_collide(velocity)
	
	if (next_action.target.position - game_object.position).length() < 10.0:
		next_action.in_range = true
		return true
	else:
		return false