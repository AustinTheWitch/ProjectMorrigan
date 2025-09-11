extends player_states
class_name player_blink

static var blink_direction: float
var start_point: Vector2

func enter() -> void:
	character_id.defense_type = "null"
	start_point = character_id.position
	print("BLINK STATE")
	if player_previous_state == "run" or player_previous_state == "fall": 
		blink_direction = facing
	else: blink_direction = -facing
	character_id.blink_charges += 1
	character_id.blink.start(character_id.blink_cooldown)
func physics_update(_delta: float) -> void:
	#set velocity
	character_id.velocity.x = (character_id.speed * 5) * blink_direction
	character_id.move_and_slide()
	if character_id.position.distance_to(start_point) >= character_id.blink_distance: state_change.emit(self, "idle")
	elif character_id.velocity == Vector2.ZERO: state_change.emit(self, "idle")
func exit() -> void:
	player_previous_state = "blink"
