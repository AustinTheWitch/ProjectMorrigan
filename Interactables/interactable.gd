extends Area2D
class_name interactable

var in_range: bool
var interacted: bool
@export var lock: bool
@export var key: interactable
var user: character
func _on_body_entered(body: Node2D) -> void: 
	in_range = true
	print("here")
func _on_body_exited(body: Node2D) -> void: 
	in_range = false
	user = null
	print("left")
func interaction() -> void: 
	if Input.is_action_just_pressed("interact") and in_range: print("NO INTERACTION FUNC SETUP")
func _process(delta: float) -> void: interaction()
