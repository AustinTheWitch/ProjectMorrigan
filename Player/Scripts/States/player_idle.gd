extends player_states
class_name player_idle

func enter() -> void: pass
func exit() -> void: pass
func update(delta: float) -> void:
	#set animation
	if !player_character.animation_player.has_animation("idle"): print("NO IDLE ANIM")
	else: player_character.animation_player.play("idle")
func physics_update(delta: float) -> void:
	if Input.get_axis("ui_left", "ui_right"): state_change.emit(self, "run")
	if !player_character.is_on_floor(): state_change.emit(self, "fall")
