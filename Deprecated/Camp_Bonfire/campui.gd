extends CanvasLayer
@export var camp: Camp
@onready var rest_button: Button = $Content_Box/Menu/Rest_Button
@onready var spells_button: Button = $Content_Box/Menu/Spells_Button
@onready var familiars_button: Button = $Content_Box/Menu/Familiars_Button
@onready var converse_button: Button = $Content_Box/Menu/Converse_Button
func _on_converse() -> void:
	Dialogueui.conversation_start(camp.camp_dialogue)
	visible = !visible
	camp.converse_button.visible = false
