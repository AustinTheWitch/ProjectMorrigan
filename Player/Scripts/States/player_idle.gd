extends player_states
class_name player_idle

func enter() -> void:
	character_id.velocity = Vector2.ZERO
	print("IDLE STATE")
func update(_delta: float) -> void:
	#input to different states
	if Input.is_action_just_pressed("weapon") and character_id.atk_ready: state_change.emit(self, "windup")
	elif Input.is_action_just_pressed("blink") and character_id.blink_charges < character_id.max_charges: state_change.emit(self, "blink")
	elif Input.is_action_just_pressed("ward"): state_change.emit(self, "deflect")
	#healing input
	if Input.is_action_just_pressed("familiar"): 
		character_id.familiar_heal.emit(character_id.current_health, character_id.max_health)
		print(character_id.current_health)

func physics_update(_delta: float) -> void: 
	if Input.get_axis("ui_left", "ui_right"): state_change.emit(self, "run")
	if !character_id.is_on_floor(): state_change.emit(self, "fall")
func exit() -> void: 
	player_previous_state = "idle"
	character_id.weapon.area_2d.set_collision_mask_value(6, false)
