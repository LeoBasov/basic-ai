extends "res://scenes/AI/FiniteState.gd"

func update(object):
	if object.found_food:
		var vec = object.found_food.position - object.position
		object.velocity = vec.normalized()*object.SPEED
		object.move_and_collide(object.velocity)
		
	else:
		emit_signal("pop_push", "StateSearch")