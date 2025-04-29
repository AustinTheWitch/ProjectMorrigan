extends weapon_base
#preload section
var staff_weapon: WEAPON = preload("res://Weapon/Types/staff.tres")
#weapon selection / loadout
var current_wpn = 0
var weapon_loadout: Array[WEAPON] = [staff_weapon, staff_weapon, staff_weapon]
func _ready() -> void: 
	ray_cast_2d.set_collision_mask_value(set_mask(), true)
	set_weapon(weapon_loadout.get(current_wpn))
func _process(delta: float) -> void:
	ray_cast_2d.target_position.x = get_parent().direction * weapn_reach
	if Input.is_action_just_pressed("weapon"): attack_startup()
	if Input.is_action_just_released("weapon"): 
		if melee: attack_finish(attack_string(heavy_atk, weapn_name))
		else: pass #ranged_attack()
	weapon_swap()
func weapon_swap(): 
	if Input.is_action_just_pressed("Debug"): 
		if current_wpn >= 2: current_wpn = 0
		else: current_wpn += 1
		set_weapon(weapon_loadout.get(current_wpn))
