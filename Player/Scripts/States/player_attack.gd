extends player_states
class_name player_attack

func enter() -> void:
	character_id.atk_weight = false
	character_id.attack_windup.start(0.7)
func update(_delta: float) -> void:
	if Input.is_action_just_released("weapon"): pass
	elif Input.is_action_just_pressed("weapon"): pass
	elif Input.is_action_just_pressed("blink"): blink()
	elif Input.is_action_just_pressed("ward"): state_change.emit(self, "ward")
func physics_update(_delta: float) -> void:
	if Input.get_axis("ui_left", "ui_right"): state_change.emit(self, "run")
	fall()
func exit() -> void:
	if character_id.atk_number > 3: character_id.atk_number = 0
	else: character_id.atk_number += 1
	character_id.atk_weight = false
	player_previous_state = "attack"
	print("attack state left")
func attack_id() -> String: 
	var attack_string = character_id.weapon.attack_string(character_id.atk_weight, character_id.atk_number)
	return attack_string
