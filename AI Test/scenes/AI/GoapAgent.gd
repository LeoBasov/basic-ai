extends Node

var available_actions : Array
var current_actions : Array

func _ready():
	available_actions = []
	current_actions = []
	#planner = GoapPlaner.new()
	#findDataProvider ();
	#createIdleState ();
	#createMoveToState ();
	#createPerformActionState ();
	#stateMachine.pushState (idleState);
	#loadActions ();
	
func update() -> void:
	$FiniteStateMachine.update()
	
func add_action(action : GoapAction) -> void:
	available_actions.push_back(action)

func remove_action(action : GoapAction) -> void:
	for i in available_actions.size():
		if available_actions[i] == action:
			available_actions.remove(i)
			break

func has_action_plan() -> bool:
	return current_actions.size() > 0

func load_actions() -> void:
	#implement this
	pass