extends player_states
class_name player_use_gate

func enter() -> void: 
	print("USING WITCH STATE")
func update(_delta: float) -> void:
	interact.interaction()
	if Input.is_action_just_pressed("Debug"): state_change.emit(self, "idle")
func physics_update(_delta: float) -> void: pass
func exit() -> void: pass
