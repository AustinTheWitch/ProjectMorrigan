extends player_states
class_name player_fall
func enter() -> void: 
	print("FALL STATE")
	character_id.recovered = false
func physics_update(_delta: float) -> void: 
	if !character_id.is_on_floor(): character_id.velocity.y += character_id.GRAVITY * _delta
	elif character_id.is_on_floor(): state_change.emit(self, "ground")
	character_id.move_and_slide()
	if Input.is_action_just_pressed("weapon"): state_change.emit(self, "dropattack")
	elif Input.is_action_just_pressed("blink"): 
		character_id.velocity.y = 0
		state_change.emit(self, "blink")
func exit() -> void: player_previous_state = "fall"
