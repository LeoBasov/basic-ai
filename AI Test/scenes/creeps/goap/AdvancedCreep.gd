extends KinematicBody2D

func _ready():
	get_node("GoapAgent/IGoap").set_game_object(self)

func _physics_process(delta):
	$GoapAgent.update()