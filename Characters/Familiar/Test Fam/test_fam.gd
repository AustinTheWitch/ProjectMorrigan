extends familiar_base
class_name test_fam
@onready var timer: Timer = $Timer
var healing_active: bool
var healing_time_current: int
var healing_time_up: int = 19

#func healing_skill(current_health: float, max_health: float) -> void:
	#var familiar_spent = charge_system()
	#if familiar_spent and !healing_active: 
		#print("NO MORE CHARGES")
		#return
	#healing_active = true
	#var new_health: float
	#timer.start(1.0)
	#var health_additive = (max_health * 0.6) / 20 
	#new_health = current_health + health_additive
	#if new_health >= max_health: new_health = max_health
	#summoner_id.current_health = new_health
	#summoner_id.update_health.emit(new_health, max_health)
	#print(summoner_id.current_health)

#func _on_timer_timeout() -> void: 
	#healing_time_current += 1
	#healing_skill(summoner_id.current_health, summoner_id.max_health)
	#if healing_time_current >= healing_time_up: 
		#healing_time_current = 0
		#timer.stop()
		#healing_active = false
	
