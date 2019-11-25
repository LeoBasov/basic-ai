extends "res://scenes/AI/FiniteState.gd"

var move_is_possible : bool
var agent_moved : bool

signal check_if_move_possible()
signal move_agent()

func _ready():
	self.move_is_possible = false
	self.agent_moved = false
	
func set_move_is_possible(move_is_possible : bool) -> void:
	self.move_is_possible = move_is_possible

func set_agent_moved(agent_moved : bool) -> void:
	self.agent_moved = agent_moved

func update(object):
	emit_signal("check_if_move_possible")
	
	if !self.move_is_possible:
		emit_signal("pop")
		emit_signal("pop")
		emit_signal("push", "IdleState")
		return

	#get the agent to move itself
	emit_signal("move_agent")
	
	if agent_moved:
		emit_signal("pop")