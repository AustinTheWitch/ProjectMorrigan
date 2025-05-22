extends Node
class_name character_state_machine

var character_states: Dictionary[String, character_state]
@export var start_state: character_state
var current_state: character_state

func _ready() -> void:
	for state in get_children():
		if state is character_state:
			character_states[state.name.to_lower()] = state
			state.state_change.connect(state_changed)
		if state == start_state:
			start_state.enter()
			current_state = start_state
func _process(delta: float) -> void: if current_state: current_state.update(delta)
func _physics_process(delta: float) -> void: if current_state: current_state.physics_update(delta)
func state_changed(new_state, new_state_name, _selected_states: Dictionary = {}) -> void: 
	if new_state != current_state: return
	var next_state: character_state = character_states.get(new_state_name.to_lower())
	if !next_state: return
	if current_state: current_state.exit()
	next_state.enter()
	current_state = next_state
