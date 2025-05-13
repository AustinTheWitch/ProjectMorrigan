extends player_states
class_name player_fall
func enter() -> void: print("falling")
func physics_update(_delta: float) -> void:
	if pc.is_on_floor(): state_change.emit(self, "idle")
	if Input.is_action_just_pressed("blink") and pc.blink_charges < pc.max_charges:
		state_change.emit(self, "blink")
	pc.move_and_slide()
