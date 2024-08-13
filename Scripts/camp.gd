extends Area2D
var player: player_scene
func _atcamp(body: CharacterBody2D):
	if !body: return
	body.at_camp = true

func _leftcamp(body: CharacterBody2D):
	if !body: return
	body.at_camp = false

