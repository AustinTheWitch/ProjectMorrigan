extends player_states
class_name player_idle

func enter() -> void: 
	#set animation
	if !pc.animation_player.has_animation("idle"): print("NO IDLE ANIM")
	else: pc.animation_player.play("idle")
	#set velocity
	pc.velocity = Vector2.ZERO
	print(blink_direction)
func exit() -> void: pass
func update(_delta: float) -> void: pass
func physics_update(_delta: float) -> void:
	if Input.is_action_just_pressed("blink") and pc.blink_charges < pc.max_charges: 
		state_change.emit(self, "blink")
	if Input.get_axis("ui_left", "ui_right"):
		blink_direction = Input.get_axis("ui_left", "ui_right")
		state_change.emit(self, "run")
	if !pc.is_on_floor(): state_change.emit(self, "fall")
	if Input.is_action_just_pressed("ward"): state_change.emit(self, "ward")
