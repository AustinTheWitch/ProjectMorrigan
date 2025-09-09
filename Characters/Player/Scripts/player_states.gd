extends character_state
class_name player_states

static var player_previous_state: String
static var interaction_possible: bool

func enter() -> void: pass
func update(_delta: float) -> void: pass
func physics_update(_delta: float) -> void: pass
func exit() -> void: pass
