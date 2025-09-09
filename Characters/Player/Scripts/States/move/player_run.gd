extends player_states
class_name player_run
func enter() -> void:
	#setting animation tracks
	print("RUN STATE")
func update(_delta: float) -> void: 
	if Input.is_action_just_pressed("blink") and character_id.blink_charges < character_id.max_charges: state_change.emit(self, "blink")
	if Input.is_action_pressed("ward"): state_change.emit(self, "deflect")
	if Input.is_action_pressed("weapon") and character_id.atk_ready: state_change.emit(self, "windup")
func physics_update(_delta: float) -> void:
	#setting velocity
	var direction: Vector2 
	direction.x = Input.get_axis("ui_left", "ui_right")
	character_id.velocity.x = direction.normalized().x
	character_id.velocity = character_id.velocity * character_id.speed
	if direction.x * facing < 0:
		facing = direction.x
	character_id.sprite.scale.x = facing
	character_id.move_and_slide()
	#idle
	if character_id.velocity.x == 0.0: state_change.emit(self, "idle")
	#fall
	if !character_id.is_on_floor(): state_change.emit(self, "move/fall")
func exit() -> void:
	player_previous_state = "run"
	if character_id.is_on_floor(): character_id.velocity = Vector2.ZERO
