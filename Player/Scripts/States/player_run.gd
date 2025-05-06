extends player_states
class_name player_run

func physics_update(delta: float) -> void:
	#setting velocity
	player_character.velocity.x = Input.get_axis("ui_left", "ui_right")
	player_character.velocity = player_character.velocity.normalized() * player_character.speed
	player_character.animation_player.play("walking")
	player_character.move_and_slide()
	if player_character.velocity == Vector2.ZERO: state_change.emit(self, "idle")
