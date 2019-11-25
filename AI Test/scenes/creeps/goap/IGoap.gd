extends "res://scenes/AI/IGoap.gd"

func get_world_state() -> Dictionary:
	var goal : Dictionary = {}
	
	goal["get_food"] = true
	
	return goal