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

func _on_IdleState_make_plan():
	#make the actual plan
	#check if plan could be created
	$FiniteStateMachine/IdleState.set_plan_exists(has_action_plan())

func _on_IdleState_plan_failed():
	pass # Replace with function body.


func _on_MoveState_check_if_move_possible():
	pass # Replace with function body.


func _on_MoveState_move_agent():
	pass # Replace with function body.
