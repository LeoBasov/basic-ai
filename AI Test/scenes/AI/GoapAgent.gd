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
	
func add_action(action : GoapAction) -> void:
	available_actions.push_back(action)

func remove_action(action : GoapAction) -> void:
	for i in available_actions.size():
		if available_actions[i] == action:
			available_actions.remove(i)
			break

func has_action_plan() -> bool:
	return current_actions.size() > 0