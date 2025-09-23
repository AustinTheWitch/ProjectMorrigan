extends interactable
class_name door

@export var key: String
func _ready() -> void: pass
func interaction() -> void:
	if lock:
		if keylist.has(key): 
			interact_state = true
			opened()
		else: print("KEY NOT FOUND OR NOT ASSIGNED")
	else: 
		interact_state = true
		opened()
func opened() -> void:
		collision_shape_2d.set_disabled(interact_state)
		animation_player.play(animation)
