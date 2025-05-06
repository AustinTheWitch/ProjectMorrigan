extends player_states
class_name player_fall
func enter() -> void: print("Falling")
func physics_update(delta: float) -> void:
	if player_character.is_on_floor(): state_change.emit(self, "idle")
