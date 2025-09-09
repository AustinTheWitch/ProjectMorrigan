extends interactable
class_name witch_gate

var gate_active: bool = false
func interaction() -> void: 
	visible = !lock
	if Input.is_action_just_pressed("interact") and in_range: 
		if lock: return
		if gate_active: print("Gate Used")
		else:
			gate_active = true 
			print("Gate Activated")

	
