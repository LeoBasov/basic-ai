extends Node

class_name GoapAction

#string,object
var preconditions : Dictionary = {}
var effects : Dictionary = {}

var in_range : bool = false
var cost : float = 1.0
var target = null #GameObject the object on which the action is applied e.g. the enemy

func _ready():
	add_to_group("Actions")

func do_reset() -> void:
	in_range = false
	target = null
	reset()
	
func reset() -> void:
	#OVERRIDE THIS
	pass
	
func is_done() -> bool:
	#OVERRIDE THIS
	return false
	
"""
Procedurally check if this action can run. Not all actions
will need this, but some might.
"""
func check_procedural_precondition(agent) -> bool: # agent : GameObject
	#OVERRIDE THIS
	return false
	
"""
Run the action.
Returns True if the action performed successfully or false
if something happened and it can no longer perform. In this case
the action queue should clear out and the goal cannot be reached.
"""
func perform(agent) -> bool:  # agent : GameObject
	#OVERRIDE THIS
	return false
	
"""
Does this action need to be within range of a target game object?
If not then the moveTo state will not need to run for this action.
"""
func requires_in_range () -> bool:
	#OVERRIDE THIS
	return false
	
"""
Are we in range of the target?
The MoveTo state will set this and it gets reset each time this action is performed.
"""
func is_in_range () -> bool:
	return in_range
	
func set_in_range(in_range: bool) -> void:
	self.in_range = in_range


func add_precondition(key : String, value : bool) -> void:
	preconditions[key] = value
	
func remove_precondition(key : String) -> void:
	var success = preconditions.erase(key)
	#DEAL with variable
	
func add_effect(key : String, value : bool) -> void:
	effects[key] = value
	
func remove_effect(key : String) -> void:
	var success = effects.erase(key)
	#DEAL with variable