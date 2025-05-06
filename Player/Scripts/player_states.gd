extends character_state
class_name player_states
@onready var player_character: player = get_parent().get_parent()

func enter() -> void: pass
func exit() -> void: pass
func update(delta: float) -> void: pass
func physics_update(delta: float) -> void: pass
