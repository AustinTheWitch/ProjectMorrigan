extends Area2D

var acessible: bool

func _on_body_entered(body: Node2D) -> void: acessible = true
func _on_body_exited(body: Node2D) -> void: acessible = false
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and acessible: print("bonfire in use")
