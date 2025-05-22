extends Node
class_name character_state
signal state_change

@onready var character_id: character = get_parent().get_parent()
var animation_string: String

func enter() -> void: pass
func exit() -> void: pass
func update(_delta: float) -> void: pass
func physics_update(_delta: float) -> void: pass

func create_animation_id(weapon: String, action: String) -> void:
	animation_string = weapon + "/" + action
	if !character_id.animation_player.has_animation(animation_string): print(animation_string + " DOES NOT EXIST")
	else: character_id.animation_player.play(animation_string)

func fall() -> void: if !character_id.is_on_floor(): state_change.emit(self, "fall")
func blink() -> void: 
	if character_id.blink_charges < character_id.max_charges: state_change.emit(self, "blink")
