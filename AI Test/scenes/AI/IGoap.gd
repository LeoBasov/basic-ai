extends Node

class_name IGoap

"""
 * Collect the world data for this Agent that will be
 * used for GOAP planning.
"""

"""
 * Any agent that wants to use GOAP must implement
 * this interface. It provides information to the GOAP
 * planner so it can plan what actions to use.
 * 
 * It also provides an interface for the planner to give 
* feedback to the Agent and report success/failure.
"""

"""
	 * The starting state of the Agent and the world.
	 * Supply what states are needed for actions to run.
"""

var game_object

func _ready():
	game_object = null
	
func set_game_object(game_object) -> void:
	self.game_object = game_object

func get_world_state() -> Dictionary:
	#OVERRIDE THIS
	return {}

"""
	 * Give the planner a new goal so it can figure out 
	 * the actions needed to fulfill it.
"""
func create_goal_state() -> Dictionary:
	#OVERRIDE THIS
	return {}

"""
	 * No sequence of actions could be found for the supplied goal.
	 * You will need to try another goal
"""
func plan_failed(failed_goal : Dictionary) -> void:
	#OVERRIDE THIS
	pass

"""
	 * A plan was found for the supplied goal.
	 * These are the actions the Agent will perform, in order.
"""
func plan_found(goal : Dictionary, actions : Array) -> void: #(HashSet<KeyValuePair<string,object>> goal, Queue<GoapAction> actions)
	#OVERRIDE THIS
	pass

"""
	 * All actions are complete and the goal was reached. Hooray!
"""
func actions_finished() -> void:
	#OVERRIDE THIS
	pass

"""
	 * One of the actions caused the plan to abort.
	 * That action is returned.
"""
func plan_aborted(aborter : GoapAction) -> void:
	#OVERRIDE THIS
	pass

"""
	 * Called during Update. Move the agent towards the target in order
	 * for the next action to be able to perform.
	 * Return true if the Agent is at the target and the next action can perform.
	 * False if it is not there yet.
"""
func move_agent(next_action : GoapAction) -> bool:
	#OVERRIDE THIS
	return false
