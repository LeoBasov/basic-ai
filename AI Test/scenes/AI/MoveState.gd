extends "res://scenes/AI/FiniteState.gd"

var move_is_possible : bool
var move_complete : bool

signal check_if_move_possible()
signal move_agent()

func _ready():
	self.move_is_possible = false
	self.move_complete = false
	
func set_move_is_possible(move_is_possible : bool) -> void:
	self.move_is_possible = move_is_possible

func set_move_complete(move_complete : bool) -> void:
	self.move_complete = move_complete

func update(object):
	emit_signal("check_if_move_possible")
	
	if !self.move_is_possible:
		emit_signal("pop")
		emit_signal("pop")
		emit_signal("push", "IdleState")
		return

	#get the agent to move itself
	emit_signal("move_agent")
	
	if self.move_complete:
		emit_signal("pop")