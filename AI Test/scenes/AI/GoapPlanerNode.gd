extends Node

"""
In node class Node. This needs another name.
Used for building up the graph and holding the running costs of actions.
"""

class_name GoapPlanerNode

var running_cost : float
var state : Dictionary
var action : GoapAction

func _init(parent : GoapPlanerNode, running_cost : float, state : Dictionary, action : GoapAction):
	self.parent = parent;
	self.running_cost = running_cost;
	self.state = state;
	self.action = action;