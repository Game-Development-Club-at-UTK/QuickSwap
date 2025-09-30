extends Node
class_name EnemyStateMachine

var active_state : State = null
var states : Array[State] = []

func _ready() -> void:
	for child in get_children():
		if child is State:
			states.append(child as State)
	
	if states.size() > 0:
		set_state(states[0])

func set_state(new_state: State) -> void:
	if active_state:
		active_state.exit()
	active_state = new_state
	active_state.enter()

func change_state(state_name: String) -> void:
	var new_state = get_state(state_name)
	set_state(new_state)

func input(event) -> void:
	var new_state = active_state.input(event)
	if new_state:
		set_state(new_state)

func update(delta) -> void:
	if active_state:
		var new_state = active_state.update(delta)
		if new_state:
			set_state(new_state)
			
func get_state(state_name: String) -> State:
	for state in states:
		if state.name == state_name:
			return state
	return null
