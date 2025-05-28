extends player_states
class_name player_blink

static var blink_direction: float
func enter() -> void: 
	if player_previous_state == "run": blink_direction = player_direction * 1.5
	else: blink_direction = -player_direction * 1
	character_id.blink_system()
	#set animation
	create_animation_id(character_id.weapon.wpn_name, "blink")
	await character_id.animation_player.animation_finished
	state_change.emit(self, "idle")
func physics_update(_delta: float) -> void:
	#set velocity
	character_id.velocity.x = character_id.blink_distance * blink_direction
	character_id.move_and_slide()
func exit() -> void:
	character_id.velocity = Vector2.ZERO
	player_previous_state = "blink"
