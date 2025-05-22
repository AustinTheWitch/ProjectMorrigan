extends player_states
class_name player_idle

func enter() -> void:
	create_animation_id(character_id.weapon.wpn_name, "idle")
	#character_id.weapon.area_2d.set_collision_mask_value(6, false)

func update(_delta: float) -> void: pass

func physics_update(_delta: float) -> void: 
	fall()
	if Input.get_axis("ui_left", "ui_right"): run()

func exit() -> void: pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("weapon"): attack()
	elif event.is_action_pressed("blink"): blink()
	elif event.is_action_pressed("ward"): ward()
	if event.is_action_pressed("ui_left"): player_direction = -1.0
	elif event.is_action_pressed("ui_right"): player_direction = 1.0
	else: return
