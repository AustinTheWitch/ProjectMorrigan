extends character
class_name player
func _ready() -> void:
	signal_connections()
	player_stats()
	damage_taken.emit(current_health, max_health)
	equip_weapon()
func _physics_process(delta: float) -> void:
	gravity(delta)
	move_and_slide()
func blink_system()-> void:
	blink_charges += 1
	blink_timer.start(blink_cooldown)
func _on_blink_timeout() -> void: blink_charges -= 1
func player_stats() -> void:
	speed = 170
	current_health = 10
	max_health = 10
func combo_system() -> void:
	combo_reset.start(1.0)
	if atk_number >= 3: atk_number = 0
	else: atk_number += 1
func _on_combo_reset_timeout() -> void: atk_number = 0
func _on_attack_windup_timeout() -> void: atk_weight = true
