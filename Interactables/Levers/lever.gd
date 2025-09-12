extends interactable
class_name lever

@export var unlock: interactable

func _ready() -> void: pass
func interaction() -> void:
	if lock: print("THE LEVER IS LOCKED. ASSIGN A KEY OR OBJECT TO THIS")
	elif unlock == null: 
		print(" NO INTERACTABLE FOUND OR ASSIGNED. ASSIGN A INTERACTABLE TO UNLOCK VARIABLE")
		return
	interact_state = true
	collision_shape_2d.set_disabled(interact_state)
	animation_player.play(animation)
	#unlocks/opens interactable target
	unlock.interact_state = true
	unlock.collision_shape_2d.set_disabled(interact_state)
	unlock.animation_player.play(unlock.animation)
