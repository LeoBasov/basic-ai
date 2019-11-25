extends Node

var available_actions : Array
var current_actions : Array
var data_provider : IGoap

func _ready():
	available_actions = []
	current_actions = []
	find_data_provider()
	$FiniteStateMachine.push_state($FiniteStateMachine/IdleState)
	load_actions()
	
func find_data_provider():
	data_provider = $IGoap
	
func load_actions() -> void:
	#implement this
	pass
	
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

func _on_MoveState_get_current_action():
	$FiniteStateMachine/MoveState.set_current_action(current_actions.back())
