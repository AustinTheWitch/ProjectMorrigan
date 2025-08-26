extends player_states
class_name player_attack

func enter() -> void:
	print("ATTACK STATE")
	character_id.attacking = true
	character_id.animation_player.play("greatsword/light0")
	#player attack
	character_id.atk_number += 1
	state_change.emit(self, "idle")
func update(_delta: float) -> void: if character_id.atk_ready: state_change.emit(self, "idle")
func physics_update(_delta: float) -> void: if !character_id.is_on_floor(): state_change.emit(self, "fall")
func exit() -> void:
	character_id.attacking = false
	character_id.atk_type = false
	player_previous_state = "attack"
	#combo
	character_id.combo.start(3)
	character_id.weapon.area_2d.set_collision_mask_value(6, false)
