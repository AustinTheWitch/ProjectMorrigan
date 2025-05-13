extends player_states
class_name player_run
func enter() -> void: print("running")
func physics_update(_delta: float) -> void:
	#setting animation tracks
	if !pc.animation_player.has_animation("run"): print("NO RUN ANIM")
	else: pc.animation_player.play("run")

	#setting velocity
	pc.velocity.x = Input.get_axis("ui_left", "ui_right")
	pc.velocity = pc.velocity.normalized() * pc.speed
	pc.move_and_slide()
	#state changes
	if Input.is_action_just_pressed("blink") and pc.blink_charges < pc.max_charges:
		state_change.emit(self, "blink")
	if !pc.is_on_floor(): 
		var temp_vel: Vector2 = pc.velocity.normalized()
		blink_direction = temp_vel.x
		state_change.emit(self, "fall")
	if pc.velocity == Vector2.ZERO: 
		blink_direction = -blink_direction
		state_change.emit(self, "idle")
