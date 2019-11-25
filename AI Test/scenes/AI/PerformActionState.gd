extends "res://scenes/AI/FiniteState.gd"

func _ready():
	pass

func update(object):
	var data_provider = object.get_node("GoapAgent/IGoap")
	var current_actions = object.get_node("GoapAgent").current_actions
	var action : GoapAction = current_actions.back()
	
	if action.is_done():
		# the action is done. Remove it so we can perform the next one
		current_actions.pop_back()

	if current_actions.size() != 0:
		# perform the next action
		action = current_actions.back()
		var inRange : bool = action.is_in_range() if action.requires_in_range() else true

		if inRange:
			# we are in range, so perform the action
			var success : bool = action.perform(data_provider)

			if !success:
				# action failed, we need to plan again
				emit_signal("pop")
				emit_signal("push", "IdleState")
				data_provider.plan_aborted(action)

		else:
			# we need to move there first
			# push moveTo state
			emit_signal("push", "MoveState")

	else:
		# no actions left, move to Plan state
		emit_signal("pop")
		emit_signal("push", "IdleState")
		data_provider.actions_finished()
