extends player_states
class_name player_blink

static var blink_direction: float
var start_point: Vector2

func enter() -> void:
	start_point = character_id.position
	if player_previous_state == "run" or "blink": blink_direction = facing
	else: blink_direction = -facing
	character_id.blink_system()
func physics_update(_delta: float) -> void:
	#set velocity
	character_id.velocity.x = (character_id.speed * 5) * blink_direction
	character_id.move_and_slide()
	if character_id.position.distance_to(start_point) >= character_id.blink_distance: state_change.emit(self, "idle")
	elif character_id.velocity == Vector2.ZERO: state_change.emit(self, "idle")
func exit() -> void:
	player_previous_state = "blink"
