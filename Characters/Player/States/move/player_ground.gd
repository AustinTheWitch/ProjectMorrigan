extends player_states
class_name player_ground

func enter() -> void: 
	print("LAND STATE")
	character_id.recovery.start(0.7)
func update(_delta: float) -> void: if character_id.recovered: state_change.emit(self, "idle")
func physics_update(_delta: float) -> void: pass
func exit() -> void: 
	player_previous_state = "ground"
	print("fall damage here")
