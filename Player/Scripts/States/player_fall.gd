extends player_states
class_name player_fall
func enter() -> void: 
	var temp_vel: Vector2
	temp_vel = pc.velocity / 2
	temp_vel = temp_vel.normalized()
	
func physics_update(delta: float) -> void:
	if pc.is_on_floor(): state_change.emit(self, "idle")
	if Input.is_action_just_pressed("blink") and pc.blink_charges < pc.max_charges:
		state_change.emit(self, "blink")
	pc.move_and_slide()
