extends player_states
class_name player_ward

func enter() -> void:
	print("WARD STATE")
	character_id.defense_type = "warding"
func update(_delta: float) -> void:
	warding = Input.is_action_pressed("ward")
	if !warding: state_change.emit(self, "idle")
	if Input.is_action_just_pressed("blink"): state_change.emit(self, "blink")
func physics_update(_delta: float) -> void: if !character_id.is_on_floor(): state_change.emit(self, "fall")
func exit() -> void: 
	character_id.defense_type = "null"
	player_previous_state = "ward"
	print("not warding")
