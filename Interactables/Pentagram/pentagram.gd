extends Area2D

var acessible: bool
var bonfire_lit: bool = false

func _on_body_entered(body: Node2D) -> void: acessible = true
func _on_body_exited(body: Node2D) -> void: acessible = false
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and acessible: 
		if bonfire_lit: print("Used Bonfire")
		else:
			bonfire_lit = true 
			print("activated")
