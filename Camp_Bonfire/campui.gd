extends CanvasLayer
@export var camp: Camp
func _on_converse() -> void:
	Dialogueui.conversation_start(camp.camp_dialogue)
	visible = !visible
	
