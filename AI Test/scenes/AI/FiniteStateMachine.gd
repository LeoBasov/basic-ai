extends Node

var state_stack : Array

func _init():
	self.state_stack = []
	
func _ready():
	for node in get_tree().get_nodes_in_group("States"):
		node.connect("pop", self, "_on_State_pop")
		node.connect("push", self, "_on_State_push")
	
func update(object) -> void:
	var current_state :  FiniteState = get_current_state()
	
	if current_state != null:
		current_state.update(object)
	
func pop_state() -> FiniteState:
	return self.state_stack.pop_back()
	
func push_state(state : FiniteState) -> void:
	if get_current_state() != state:
		self.state_stack.push_back(state)
	
func get_current_state() -> FiniteState:
	return  (self.state_stack.back() if self.state_stack.size() > 0 else null)
	
func _on_State_pop():
	self.pop_state()
	
func _on_State_push(state_name):
	self.push_state(get_node(state_name))