extends interactable
class_name ladder

@export var end_point: Node2D

func interaction() -> void: 
	if Input.is_action_just_pressed("interact") and in_range:
		print("ladder in use")
