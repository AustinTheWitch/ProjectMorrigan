extends Area2D
class_name interactable

@export var key: String
@export var lock: bool
var interact_name: String
var interact_state: bool

func _on_body_entered(body: Node2D) -> void: 
	print("here")
	body.interaction = true
func _on_body_exited(body: Node2D) -> void: 
	print("left")
	body.interaction = false

func interaction() -> void: pass
	#if Input.is_action_just_pressed("interact") and in_range: print("NO INTERACTION FUNC SETUP")
func _process(delta: float) -> void: interaction()
