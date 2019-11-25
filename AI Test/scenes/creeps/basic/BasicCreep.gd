extends KinematicBody2D

const SPEED = 5.0

var velocity : Vector2
var found_food

func _process(delta):
	$Label.text = $Brain.get_current_state().name

func _ready():
	velocity = Vector2(0.0, 0.0)
	found_food = null
	
	for state in get_tree().get_nodes_in_group("State"):
		state.connect("pop", self, "_on_State_pop")
		state.connect("push", self, "_on_State_push")
		state.connect("pop_push", self, "_on_State_pop_push")
		
	$Brain.push_state($StateSearch)
	$Label.text = $Brain.get_current_state().name

func _physics_process(delta):
	$Brain.update(self)
	
func _on_State_pop():
	$Brain.pop_state()
	
func _on_State_push(state):
	$Brain.push_state(get_node(state))
	
func _on_State_pop_push(state):
	$Brain.pop_state()
	$Brain.push_state(get_node(state))