extends player_states
class_name player_run
func enter() -> void:
	#setting animation tracks
	create_animation_id(character_id.weapon.wpn_name, "run")
func physics_update(_delta: float) -> void:
	#setting velocity
	character_id.velocity.x = Input.get_axis("ui_left", "ui_right")
	character_id.velocity = character_id.velocity.normalized() * character_id.speed
	character_id.move_and_slide()
	if !Input.is_anything_pressed(): state_change.emit(self, "idle")
	if !character_id.is_on_floor(): state_change.emit(self, "fall")
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("blink"): blink()
func exit() -> void: 
	if !character_id.is_on_floor(): 
		var temp_vel: Vector2 = character_id.velocity.normalized()
	else: character_id.velocity = Vector2.ZERO
