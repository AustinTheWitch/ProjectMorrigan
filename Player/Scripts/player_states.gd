extends character_state
class_name player_states
@onready var pc: player = get_parent().get_parent()
#blink
static var blink_direction: float

func enter() -> void: pass
func exit() -> void: pass
func update(_delta: float) -> void: pass
func physics_update(_delta: float) -> void: pass
