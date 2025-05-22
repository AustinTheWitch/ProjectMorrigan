extends player_states
class_name player_attack

static var attack_cancel: bool
func enter() -> void: 
	attack_cancel = false
	character_id.atk_weight = false
	character_id.attack_windup.start(0.7)

func update(_delta: float) -> void: pass

func physics_update(_delta: float) -> void: pass

func _input(event: InputEvent) -> void:
	if event.is_action_released("weapon"): pass
	elif event.is_action_pressed("blink"): blink()
	elif event.is_action_pressed("ward"): state_change.emit(self, "ward")
	else: return

func exit() -> void: 
	character_id.combo_reset.start(0.8)
	if character_id.atk_number > 3: character_id.atk_number = 0
	else: character_id.atk_number += 1
	character_id.atk_weight = false

func attack_id() -> String: 
	var attack_string = character_id.weapon.attack_string(character_id.atk_weight, character_id.atk_number)
	return attack_string
