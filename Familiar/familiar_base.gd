extends character
class_name familiar_base
#familiar refs
@export var summoner_id: character
@export var active_familiar: FAMILIAR
#familiar shared data
var skill_charges: int = 0
var max_charges: int = 1
var movement_type: String

func _ready() -> void:
	speed = 400
	if active_familiar == null: print("NO ACTIVE FAMILIAR")
	else: load_familiar(active_familiar)
	summoner_id.familiar = self
	summoner_id.familiar_binding()

func load_familiar(active_familiar: FAMILIAR) -> void:
	skill_charges = active_familiar.current_charges
	max_charges = active_familiar.max_charges
	movement_type = active_familiar.movement

func healing_skill(current_health: float, max_health: float) -> void:
	var new_health: float
	var health_additive = max_health * 0.4
	new_health = current_health + health_additive
	if new_health >= max_health: new_health = max_health
	summoner_id.current_health = new_health
	summoner_id.update_health.emit(current_health, max_health)

func healing_charges() -> bool:
	if skill_charges >= max_charges: 
		print("NO MORE HEALING CHARGES")
		return true
	else: return false
