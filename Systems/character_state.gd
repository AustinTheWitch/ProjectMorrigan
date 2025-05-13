extends Node
class_name character_state
signal state_change

var current_animation: String
var next_animation: String

func enter() -> void: pass
func exit() -> void: pass
func update(_delta: float) -> void: pass
func physics_update(_delta: float) -> void: pass
