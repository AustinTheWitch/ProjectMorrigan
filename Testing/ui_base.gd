extends CanvasLayer
class_name base_ui

@export var character_scene: character
static var game_state: String
static var paused_state: bool
#input function
func _unhandled_input(event: InputEvent) -> void: pass
