extends player_states
class_name player_lightattack

func enter() -> void:
	print("LIGHT ATTACK STATE")
	character_id.weapon.area_2d.set_collision_mask_value(6, true)
	character_id.animation_player.play("greatsword/light")
	await character_id.animation_player.animation_finished
	state_change.emit(self, "idle")
func update(_delta: float) -> void: pass
func physics_update(_delta: float) -> void: if !character_id.is_on_floor(): state_change.emit(self, "fall")
func exit() -> void:
	player_previous_state = "lightattack"
	character_id.weapon.area_2d.set_collision_mask_value(6, false)
