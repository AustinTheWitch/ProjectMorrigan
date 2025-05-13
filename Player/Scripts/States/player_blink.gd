extends player_states
class_name player_blink

func enter() -> void: 
	pc.blink_system()
	#set animation
	if !pc.animation_player.has_animation("blink"): print("NO BLINK ANIM FOUND")
	else: pc.animation_player.play("blink")
	#diable collision layer
	#pc.set_collision_layer_value(1, false)
	#await pc.animation_player.animation_finished
	#pc.set_collision_layer_value(1, true)
func physics_update(_delta: float) -> void:
	#set velocity
	pc.velocity.x = pc.blink_distance * blink_direction
	pc.move_and_slide()
	#temp state change stop
	if Input.is_action_just_pressed("Debug"): state_change.emit(self, "idle")
