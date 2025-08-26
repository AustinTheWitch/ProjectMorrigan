extends weapon_base
class_name greatsword

func damage_formula(body: Node2D, attack_string: String) -> float:
	var new_health: float = body.current_health
	var initial_damage: float = weapon_attacks.get(attack_string)
	if user.deflecting: new_health -= 0
	elif user.warding: new_health = initial_damage / 2
	else: new_health -= initial_damage
	print(new_health)
	return new_health
