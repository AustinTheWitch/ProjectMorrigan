extends familiar_state
class_name familiar_idle

func enter() -> void: 
	print("idle here")
	character_id.velocity = Vector2.ZERO
	summoner_object = character_id.summoner_id
func update(_delta: float) -> void: 
	if Input.is_action_just_pressed("familiar"): 
		if character_id.charges <= 0: print("NO MORE HEALING; REST TO REPLENISH")
		else: state_change.emit(self, "heal")
func physics_update(_delta: float) -> void: 
	if character_id.position.distance_to(summoner_object.position) >= 150.0: state_change.emit(self, "follow")
func exit() -> void: pass
