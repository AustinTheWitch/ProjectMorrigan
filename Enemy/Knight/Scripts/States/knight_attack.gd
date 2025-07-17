extends knight_states
class_name knight_attack

func enter() -> void: print("KNIGHT ATTACK")
func update(_delta: float) -> void: pass
func physics_update(_delta: float) -> void: 
	if character_id.position.distance_to(player_object.position) > 250.0: state_change.emit(self, "chase")

func exit() -> void: pass
