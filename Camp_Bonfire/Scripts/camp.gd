extends Area2D
class_name Camp
func _atcamp(body: CharacterBody2D):
	if !body is player_scene: return
	body.current_camp = self

func _leftcamp(body: CharacterBody2D):
	if !body is player_scene: return
	body.current_camp = null

@onready var camp_ui: CanvasLayer = $Camp_UI
@export var camp_dialogue: Dialogue
@export var converse_target: String
var converse_button: Button
func campui():
	camp_ui.visible = !camp_ui.visible
	converse_button = camp_ui.find_child("Converse_Button")
	converse_button.set_text("Converse with " + converse_target)
func ui_visible():
	camp_ui.visible = true
