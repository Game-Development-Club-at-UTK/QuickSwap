class_name StateMachine
extends Node

@export var initialState : State

var currentState : State
var states : Dictionary = {
	
}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.transition.connect(_on_child_transition)
	
	if initialState:
		initialState.enter()
		currentState = initialState
	else:
		print("WARNING: NO INITIAL STATE SET FOR (%s)" % get_parent().name)

func _process(delta):
	#print(currentState)
	
	if currentState:
		currentState.update(delta)

func _physics_process(delta):
	if currentState:
		currentState.physics_update(delta)

func _on_child_transition(state : State, newStateName : String):
	if state != currentState:
		return
		
	var newState = states.get(newStateName)
	
	if !newState:
		return
	
	if currentState:
		currentState.exit()
		
	newState.enter()
	
	currentState = newState
