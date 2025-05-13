extends player_states
class_name player_ward
func enter() -> void:
	if !pc.animation_player.has_animation("ward"): print("NO WARD ANIM")
	else: pc.animation_player.play("ward")
	pc.perfect_ward = true
	print("warding")
func update(_delta: float) -> void: 
	pc.ward_up = Input.is_action_pressed("ward")
	#if pc.animation_player.animation_finished: 
		#pc.perfect_ward = false
	#state changes
	if Input.get_axis("ui_left", "ui_right"): state_change.emit(self, "run")
	if !pc.ward_up: 
		print("not warding")
		state_change.emit(self, "idle")
