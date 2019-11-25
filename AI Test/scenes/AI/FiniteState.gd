extends Node

class_name FiniteState

signal pop()
signal push(state)
signal pop_push(state)

func _ready():
	add_to_group("States")

func update(object):
	pass