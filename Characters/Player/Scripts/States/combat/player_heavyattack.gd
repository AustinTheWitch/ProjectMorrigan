extends player_states
class_name player_heavyattack

func enter() -> void:
	print("HEAVY ATTACK STATE")
	character_id.animation_player.play("greatsword/heavy")
	await character_id.animation_player.animation_finished
	state_change.emit(self, "idle")
func update(_delta: float) -> void: if character_id.atk_ready: state_change.emit(self, "idle")
func physics_update(_delta: float) -> void: if !character_id.is_on_floor(): state_change.emit(self, "fall")
func exit() -> void:
	character_id.attacking = false
	character_id.atk_type = false
	player_previous_state = "heavyattack"
	#combo
	character_id.combo.start(3)
	character_id.weapon.area_2d.set_collision_mask_value(6, false)
