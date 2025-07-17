extends Node
class_name character_state
signal state_change

@onready var character_id: character = get_parent().get_parent()
static var facing: float = 1.0

func enter() -> void: pass
func update(_delta: float) -> void: pass
func physics_update(_delta: float) -> void: pass
func exit() -> void: pass
