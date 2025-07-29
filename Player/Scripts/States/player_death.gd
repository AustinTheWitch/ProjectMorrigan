extends player_states
class_name player_death

func enter() -> void: 
	character_id.animation_player.play(character_id.weapon.weapon_name + "/death")
	print("player died; restart")
func update(_delta: float) -> void: pass
func physics_update(_delta: float) -> void: pass
func exit() -> void: pass
