extends "res://scenes/AI/FiniteState.gd"

var plan_exists : bool

signal make_plan()
signal plan_failed()

func _ready():
	self.plan_exists = false

func set_plan_exists(plan_exists : bool) -> void:
	self.plan_exists = plan_exists

func update(object) -> void:
	# Plan
	emit_signal("make_plan")
	
	if self.plan_exists:
		# we have a plan, hooray!
		emit_signal("pop") #move to PerformAction state
		emit_signal("push", "PerformActionState")

	else:
		# ugh, we couldn't get a plan
		emit_signal("plan_failed")
		emit_signal("pop") # move back to IdleAction state
		emit_signal("push","IdleState")