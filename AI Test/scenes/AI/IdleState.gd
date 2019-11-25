extends "res://scenes/AI/FiniteState.gd"

func update(object):
	print(name)
	emit_signal("pop")
	emit_signal("push", "MoveState")