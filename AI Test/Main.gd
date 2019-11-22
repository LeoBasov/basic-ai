extends Node

var Food = preload("res://scenes/food/Food.tscn")
var Creep = preload("res://scenes/creeps/basic/BasicCreep.tscn")

func _ready():
	get_tree().paused = true
	
	create_creep(Vector2(100, 100))
	create_creep(Vector2(1000, 100))

func create_food(position):
	var food = Food.instance()
	food.position = position
	add_child(food)
	food.connect("tree_exiting", self, "_on_Food_tree_exiting")
	
func create_creep(position):
	var creep = Creep.instance()
	creep.position = position
	add_child(creep)
	
func _input(event):
	if event is InputEventMouseButton and event.button_index == 1:
		create_food(event.position)
	if event is InputEventMouseButton and event.button_index == 2:
		for food in get_tree().get_nodes_in_group("Food"):
			var distance = (food.position - event.position).length()
			if distance < 10.0:
				food.queue_free()
				break
				
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().quit()
		elif event.pressed and (event.scancode == KEY_P or event.scancode == KEY_SPACE):
			get_tree().paused = !(get_tree().paused)
			
func _on_Food_tree_exiting():
	for creep in get_tree().get_nodes_in_group("Creep"):
		creep.found_food = null