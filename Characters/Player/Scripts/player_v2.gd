extends character_base


func _process(delta: float) -> void:
	player_movement()

#movement
func player_movement():
	speed = 300
	direction.x = Input.get_axis("ui_left","ui_right")
	velocity.x *= direction.x * speed
	move_and_slide()
