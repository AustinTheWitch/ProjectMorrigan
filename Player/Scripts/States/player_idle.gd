extends player_states
class_name player_idle

func enter() -> void:
	character_id.velocity = Vector2.ZERO
	create_animation_id(character_id.weapon.wpn_name, "idle")
	#character_id.weapon.area_2d.set_collision_mask_value(6, false)
func update(_delta: float) -> void:
	if Input.is_action_just_pressed("weapon") and character_id.atk_ready: 
		character_id.attack_windup.start(0.3)
	#input to different states
	if Input.is_action_just_released("weapon") and character_id.atk_ready:
		state_change.emit(self, "attack")
	elif Input.is_action_just_pressed("blink"):
		if character_id.blink_charges >= character_id.max_charges: return
		else: state_change.emit(self, "blink")
	elif Input.is_action_just_pressed("ward"): state_change.emit(self, "ward")
func physics_update(_delta: float) -> void: 
	if Input.get_axis("ui_left", "ui_right"): state_change.emit(self, "run")
	if !character_id.is_on_floor(): state_change.emit(self, "fall")
func exit() -> void: player_previous_state = "idle"
