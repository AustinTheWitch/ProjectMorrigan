extends character_state
class_name player_states
@onready var pc: player = get_parent().get_parent()
var player_direction: float
#blink
static var blink_direction: float
static var blinking: bool
static var winding_up: bool

func enter() -> void: pass
func exit() -> void: pass
func update(_delta: float) -> void: pass
func physics_update(_delta: float) -> void: pass
