extends character
class_name player

func _ready() -> void:
	signal_connections()
	player_stats()
	damage_taken.emit(current_health, max_health)
func _physics_process(delta: float) -> void:
	gravity(delta)
	move_and_slide()
func blink_system()-> void:
	blink_charges += 1
	blink_timer.start(blink_cooldown)
	print("blink on cooldown")
func _on_blink_timeout() -> void:
	blink_charges -= 1
	print("off cooldown")
func player_stats() -> void:
	speed = 170
	current_health = 10
	max_health = 10
