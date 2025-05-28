extends player_states
class_name player_fall
func enter() -> void: create_animation_id(character_id.weapon.wpn_name, "fall")
func physics_update(_delta: float) -> void: 
	character_id.move_and_slide()
	if character_id.is_on_floor(): state_change.emit(self, "idle")
func exit() -> void: player_previous_state = "fall"
