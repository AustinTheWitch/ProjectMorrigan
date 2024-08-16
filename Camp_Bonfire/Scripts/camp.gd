extends Area2D
class_name Camp
func _atcamp(body: CharacterBody2D):
	if !body is player_scene: return
	body.current_camp = self

func _leftcamp(body: CharacterBody2D):
	if !body is player_scene: return
	body.current_camp = null

@export var camp_dialogue: Dialogue
