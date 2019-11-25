extends "res://scenes/AI/GoapAction.gd"

func _ready():
	add_effect("get_food", true)

func requires_in_range () -> bool:
	return true