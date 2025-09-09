extends Node
class_name character_state
signal state_change

@export var character_id: character
static var facing: float = 1.0
#attack variables
static var atk_ready: bool
var atk_weight: bool

func enter() -> void: pass
func update(_delta: float) -> void: pass
func physics_update(_delta: float) -> void: pass
func exit() -> void: pass
