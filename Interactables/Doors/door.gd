extends interactable
class_name door

@export var key: String
func _ready() -> void: pass
func interaction() -> void:
	if lock: 
		print("DOOR IS LOCKED. FIND KEY OR SWITCH.")
		if key == "": print("ASSIGN A KEY OR SWITCH TO THIS INTERACTABLE")
	else: 
		interact_state = true
		collision_shape_2d.set_disabled(interact_state)
		animation_player.play(animation)
