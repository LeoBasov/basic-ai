extends "res://scenes/AI/FiniteState.gd"

var current_action : GoapAction
var data_provider : IGoap

signal get_current_action()

func _ready():
	current_action = null
	data_provider = null
	
func st_data_provider(data_provider : IGoap) -> void:
	self.data_provider = data_provider

func set_current_action(current_action : GoapAction) -> void:
	self.current_action = current_action

func update(object):	
	emit_signal("get_current_action")
	
	if (current_action.requiresInRange() && current_action.target == null):
		emit_signal("pop")
		emit_signal("pop")
		emit_signal("push", "IdleState")
		return

	#get the agent to move itself
	if data_provider.moveAgent(current_action):
		emit_signal("pop")