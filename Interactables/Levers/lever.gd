extends interactable
class_name lever

@export var unlock: interactable
@export var key_item: String

func _ready() -> void: pass
func interaction() -> void:
	if lock:
		if keylist.has(key_item): 
			interact_state = true
			unlocked()
		else: print("KEY NOT FOUND OR NOT ASSIGNED")
	elif unlock == null: 
		print("NO INTERACTABLE FOUND OR ASSIGNED. ASSIGN A INTERACTABLE TO UNLOCK VARIABLE")
		return
	else:
		interact_state = true
		unlocked()
func unlocked() -> void:
		collision_shape_2d.set_disabled(interact_state)
		animation_player.play(animation)
#unlocks/opens interactable target*
		unlock.interact_state = true
		unlock.collision_shape_2d.set_disabled(interact_state)
		unlock.animation_player.play(unlock.animation)
