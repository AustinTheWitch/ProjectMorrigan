extends player_states
class_name player_lever

func enter() -> void: 
	print("LEVER STATE")
func update(_delta: float) -> void:
	interact.interaction()
	state_change.emit(self, "idle")
func physics_update(_delta: float) -> void: pass
func exit() -> void: pass
