extends Node2D
class_name weapon

#damage values per attack
var damage: Dictionary[String, float] = {"meleetest1": 1.0, }
#range detection
var range_type: String
var range_limit: float
#weapon type
var type: String
#combo
var cur_combo: int
var combo_limit: int
func damage_table() -> void:
	damage.set("meleetest1", 1.0)
func attack_type(range_type, weapon_type) -> float: 
	var attack = range_type + weapon_type + str(cur_combo)
	if damage.has(attack): return damage.get(attack)
	else: return 0
