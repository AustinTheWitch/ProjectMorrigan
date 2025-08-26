extends knight_state
class_name knight_chase

func enter() -> void: pass
func update(_delta: float) -> void: 
	if character_id.current_health <= 0: state_change.emit(self, "death")
func physics_update(_delta: float) -> void: 
	var direction = player_object.position - character_id.position
	var face_direction = direction.normalized()
	character_id.velocity.x = direction.normalized().x
	character_id.velocity = character_id.velocity * character_id.speed
	if face_direction.x * facing < 0:
		facing = face_direction.x
	character_id.sprite.scale.x = facing
	if character_id.position.distance_to(player_object.position) <= 250.0:
		character_id.velocity = Vector2.ZERO
		#randomly select state
		state_change.emit(self, "attack")
	character_id.move_and_slide()

func exit() -> void: pass
