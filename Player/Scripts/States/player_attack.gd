extends player_states
class_name player_attack

func enter() -> void:
	#play attack
	character_id.atk_ready = false
	animation_string = character_id.weapon.wpn_name + "/" + attack_id()
	character_id.animation_player.play(animation_string)
	print(animation_string)
	await character_id.animation_player.animation_finished
	character_id.atk_number += 1
	print(character_id.atk_number)
	if character_id.atk_number >= 4: character_id.atk_number = 0
	state_change.emit(self, "idle")
func update(_delta: float) -> void: pass
func physics_update(_delta: float) -> void:
	if !character_id.is_on_floor(): state_change.emit(self, "fall")
func exit() -> void:
	character_id.animation_player.stop()
	character_id.atk_ready = true
	character_id.atk_weight = false
	player_previous_state = "attack"
	#combo start
	character_id.combo_reset.start(2.5)
	#disable hitbox
func attack_id() -> String: 
	var attack_string = character_id.weapon.attack_string(character_id.atk_weight, character_id.atk_number)
	return attack_string
