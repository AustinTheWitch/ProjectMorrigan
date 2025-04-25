extends weapon_base

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Debug"): ranged_attack()
