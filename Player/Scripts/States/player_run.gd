extends player_states
class_name player_run
func enter() -> void:
	#setting animation tracks
	create_animation_id(character_id.weapon.wpn_name, "run")
func update(_delta: float) -> void: 
	if Input.is_action_just_pressed("blink"): state_change.emit(self, "blink")
func physics_update(_delta: float) -> void:
	#setting velocity
	var direction: Vector2 
	direction.x = Input.get_axis("ui_left", "ui_right")
	character_id.velocity.x = direction.normalized().x
	character_id.velocity = character_id.velocity * character_id.speed
	if direction.x * facing < 0:
		facing = direction.x
	character_id.sprite.scale.x = facing
	if character_id.velocity.x == 0.0: state_change.emit(self, "idle")
	if !character_id.is_on_floor(): state_change.emit(self, "fall")
	character_id.move_and_slide()
func exit() -> void:
	player_previous_state = "run"
	if character_id.is_on_floor(): character_id.velocity = Vector2.ZERO
