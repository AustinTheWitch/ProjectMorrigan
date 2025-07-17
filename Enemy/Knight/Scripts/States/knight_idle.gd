extends knight_states
class_name knight_idle


func enter() -> void: 
	character_id.velocity = Vector2.ZERO
func update(_delta: float) -> void: 
	if character_id.player_detected: 
		player_object = character_id.player_target
		state_change.emit(self, "chase")
func physics_update(_delta: float) -> void: pass
func exit() -> void: pass
