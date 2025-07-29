extends knight_state
class_name knight_combat

func enter() -> void: 
	character_id.velocity = Vector2.ZERO
	print("combat idle")
func update(_delta: float) -> void:
	if character_id.current_health <= 0: state_change.emit(self, "death")

func physics_update(_delta: float) -> void: 
	if character_id.position.distance_to(player_object.position) > 250.0: state_change.emit(self, "chase")
func exit() -> void: pass
