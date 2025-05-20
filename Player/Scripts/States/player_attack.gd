extends player_states
class_name player_attack
@export var weapon_equipped: weapon_base

func enter() -> void: weapon_attack()
func exit() -> void: pass
func update(_delta: float) -> void: pass
func physics_update(_delta: float) -> void: pass
func weapon_attack() -> void:
	#set animations
	pc.animation_player.play(pc.equipped_weapon.attack_string())
	if pc.equipped_weapon.atk_number >= 3: return
	else: pc.equipped_weapon.atk_number += 1
	await pc.animation_player.animation_finished
func attacking() -> void: pass
