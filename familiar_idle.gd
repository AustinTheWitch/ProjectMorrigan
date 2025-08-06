extends familiar_state
class_name familiar_idle

func enter() -> void: 
	character_id.velocity = Vector2.ZERO
	if character_id.summoner_id == null: pass
	else: summoner_object = character_id.summoner_id
func update(_delta: float) -> void: pass
func physics_update(_delta: float) -> void: 
	if character_id.position.distance_to(summoner_object.position) >= 150.0: state_change.emit(self, "follow")
func exit() -> void: pass
