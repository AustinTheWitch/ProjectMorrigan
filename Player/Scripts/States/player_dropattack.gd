extends player_states
class_name player_dropattack

func enter() -> void: 
	print("DROP ATTACK STATE")
func update(_delta: float) -> void: pass
func physics_update(_delta: float) -> void: 
	character_id.velocity.x = 0
	if !character_id.is_on_floor(): character_id.velocity.y += (character_id.GRAVITY * _delta)
	if character_id.is_on_floor(): state_change.emit(self, "ground")
	character_id.move_and_slide()
func exit() -> void: player_previous_state = "dropattack"
