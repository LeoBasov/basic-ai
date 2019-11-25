extends Node

var available_actions : Array
var current_actions : Array
var data_provider : IGoap

func _ready():
	available_actions = []
	current_actions = []
	data_provider = $IGoap
	$FiniteStateMachine.push_state($FiniteStateMachine/IdleState)
	load_actions()
	
func load_actions() -> void:
	for action in get_tree().get_nodes_in_group("Actions"):
		available_actions.push_back(action)
	
func update() -> void:
	$FiniteStateMachine.update($IGoap.game_object)