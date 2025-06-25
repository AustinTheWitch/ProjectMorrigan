extends character_state
class_name player_states

static var facing: float = 1.0
static var player_previous_state: String

func enter() -> void: pass
func exit() -> void: pass
func update(_delta: float) -> void: pass
func physics_update(_delta: float) -> void: pass
