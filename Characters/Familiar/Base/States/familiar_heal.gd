extends familiar_state
class_name familiar_heal
var healing: bool

func enter() -> void:
	#play animation
	healing = true
	character_id.charges -= 1
	heal(summoner_object.current_health, summoner_object.max_health)
	summoner_object.update_healing.emit(character_id.charges, character_id.tier[character_id.upgrades])

func update(_delta: float) -> void:
	if !healing: state_change.emit(self, "idle")
func physics_update(_delta: float) -> void: pass
func exit() -> void: pass
func heal(current_health: float, max_health: float) -> void:
	var new_health: float
	var health_additive = max_health * 0.4
	new_health = current_health + health_additive
	if new_health >= max_health: new_health = max_health
	summoner_object.current_health = new_health
	summoner_object.update_health.emit(new_health, max_health)
	healing = false
