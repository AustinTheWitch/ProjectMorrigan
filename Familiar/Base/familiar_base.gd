extends character
class_name familiar_base
#familiar refs
@export var summoner_id: character
@export var active_familiar: FAMILIAR
@export var healing_ui: familiar_ui

#familiar shared data
var charges: int = 3
var upgrades: int = 0
var tier: Array[int] = [3, 4, 5]
var movement_type: String

func _ready() -> void:
	speed = 250
	if active_familiar == null: print("NO ACTIVE FAMILIAR")
	else: load_familiar(active_familiar)
	if summoner_id == null: print("NO SUMMONER FOUND")
	else: summoner_id.familiar = self
	summoner_id.update_healing.connect(healing_ui.update_familiar)
	summoner_id.update_healing.emit(charges, tier[upgrades])

func load_familiar(familiar_input: FAMILIAR) -> void:
	tier = familiar_input.tier
	movement_type = familiar_input.movement
	charges = tier[upgrades]
