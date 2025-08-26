extends knight_state
class_name knight_attack

func enter() -> void: print("KNIGHT ATTACK")
func update(_delta: float) -> void: 
	if character_id.current_health <= 0: state_change.emit(self, "death")
func physics_update(_delta: float) -> void: 
	if character_id.position.distance_to(player_object.position) > 250.0: state_change.emit(self, "chase")
	else: state_change.emit(self, "combat")
func exit() -> void: pass
