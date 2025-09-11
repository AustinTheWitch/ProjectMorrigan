extends player_states
class_name player_heavyattack

func enter() -> void:
	print("HEAVY ATTACK STATE")
	character_id.weapon.area_2d.set_collision_mask_value(6, true)
	character_id.animation_player.play("greatsword/heavy")
	await character_id.animation_player.animation_finished
	state_change.emit(self, "idle")
func update(_delta: float) -> void: pass
func physics_update(_delta: float) -> void: if !character_id.is_on_floor(): state_change.emit(self, "fall")
func exit() -> void:
	player_previous_state = "heavyattack"
	character_id.weapon.area_2d.set_collision_mask_value(6, false)
