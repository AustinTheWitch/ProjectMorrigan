extends character
class_name player

var atk_ready: bool = true

func _ready() -> void:
	signal_connections()
	player_stats()
	damage_taken.emit(current_health, max_health)
	equip_weapon()
func _physics_process(delta: float) -> void:
	gravity(delta)
func blink_system()-> void:
	blink_charges += 1
	blink_timer.start(blink_cooldown)
func _on_blink_timeout() -> void: blink_charges -= 1
func player_stats() -> void:
	speed = 400
	current_health = 10
	max_health = 10
func _on_combo_reset_timeout() -> void: atk_number = 0
func _on_attack_windup_timeout() -> void: atk_weight = true
