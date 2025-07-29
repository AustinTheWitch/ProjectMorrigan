extends character
class_name familiar_base
#familiar refs
@export var summoner_id: character
@export var active_familiar: FAMILIAR
#familiar shared data
var skill_charges: int
var max_charges: int
var movement_type: String
#on ready vars
@onready var timer: Timer = $Timer

func _ready() -> void:
	speed = 300
	if active_familiar == null: print("NO ACTIVE FAMILIAR")
	else: load_familiar(active_familiar)
	summoner_id.familiar = self

func load_familiar(active_familiar: FAMILIAR) -> void:
	skill_charges = active_familiar.current_charges
	max_charges = active_familiar.max_charges
	movement_type = active_familiar.movement

func healing_skill(current_health: int, max_health: int, damage: float) -> float:
	var new_health: float
	var health_additive = max_health * 0.4
	new_health = current_health + health_additive
	if new_health >= max_health: new_health = max_health
	return new_health
	
