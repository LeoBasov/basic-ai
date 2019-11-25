extends "res://scenes/AI/FiniteState.gd"

var plan : Array

signal get_plan()
signal plan_failed()

func _ready():
	plan = []

func set_plan(plan : Array):
	self.plan = plan

func update(object):
	# Plan
	emit_signal("get_plan")
	
	if plan.size() != 0:
		# we have a plan, hooray!
		emit_signal("pop") #move to PerformAction state
		emit_signal("push", "performActionState")

	else:
		# ugh, we couldn't get a plan
		emit_signal("plan_failed")
		emit_signal("pop") # move back to IdleAction state
		emit_signal("push","IdleState")