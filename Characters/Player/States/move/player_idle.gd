extends player_states
class_name player_idle

func enter() -> void:
	character_id.velocity = Vector2.ZERO
	character_id.defense_type = "null"
	print("IDLE STATE")
func update(_delta: float) -> void:
	#input to different states
	if Input.is_action_just_pressed("weapon"): state_change.emit(self, "windup")
	if Input.is_action_just_pressed("blink") and character_id.blink_charges < character_id.max_charges: state_change.emit(self, "Blink")
	if Input.is_action_just_pressed("ward"): state_change.emit(self, "deflect")
	if Input.is_action_just_pressed("interact"): state_change.emit(self, "door")
func physics_update(_delta: float) -> void: 
	if Input.get_axis("ui_left", "ui_right"): state_change.emit(self, "run")
	if !character_id.is_on_floor(): state_change.emit(self, "fall")
func exit() -> void: 
	player_previous_state = "idle"
	character_id.weapon.area_2d.set_collision_mask_value(6, false)
