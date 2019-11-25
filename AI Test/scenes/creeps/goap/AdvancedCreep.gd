extends KinematicBody2D

export var SPEED = 5.0

func _ready():
	get_node("GoapAgent/IGoap").set_game_object(self)

func _physics_process(delta):
	$GoapAgent.update()