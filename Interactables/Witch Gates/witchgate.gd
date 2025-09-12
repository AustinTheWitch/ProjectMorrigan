extends interactable
class_name witch_gate

@export var inactive: bool

func interaction() -> void:
	if lock: print("GATE IS UNAVAILABLE. FIND A KEY")
	elif inactive:
		inactive = false
		#animation_player.play("activate_gate")
	else: pass
		#animation_player.play("use_gate")
	

	
