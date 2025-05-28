extends player_states
class_name player_idle

func enter() -> void:
	create_animation_id(character_id.weapon.wpn_name, "idle")
	#character_id.weapon.area_2d.set_collision_mask_value(6, false)
func update(_delta: float) -> void:
	#input to different states
	if Input.is_action_just_pressed("weapon"): state_change.emit(self, "attack")
	elif Input.is_action_just_pressed("blink"): blink()
	elif Input.is_action_just_pressed("ward"): state_change.emit(self, "ward")
	#set player direction
	if Input.is_action_just_pressed("ui_left"): player_direction = -1.0
	elif Input.is_action_just_pressed("ui_right"): player_direction = 1.0
func physics_update(_delta: float) -> void: 
	fall()
	if Input.get_axis("ui_left", "ui_right"): state_change.emit(self, "run")
func exit() -> void: player_previous_state = "idle"
