extends player_states
class_name player_pickup

func enter() -> void:
	character_id.animation_player.play(character_id.weapon.weapon_name + "/pickup")
	character_id.keychain.append(interact.key_name)
	interact.interaction()
	await character_id.animation_player.animation_finished
	state_change.emit(self, "idle")
func update(_delta: float) -> void: pass
func physics_update(_delta: float) -> void: pass
func exit() -> void: pass
