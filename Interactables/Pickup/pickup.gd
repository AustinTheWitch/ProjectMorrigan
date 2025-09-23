extends interactable
class_name pickup

@export var key_name: String
func interaction() -> void:
	interact_state = true
	if interact_state: 
		print("KEY AQUIRED")
		queue_free()
