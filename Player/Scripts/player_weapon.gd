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
	melee_weapon = ray_cast_2d.is_colliding()
	if Input.is_action_just_pressed("weapon"): attack_startup(attack_id(melee_weapon, heavy_atk, attack_string)) 
	if Input.is_action_just_released("weapon"): pass
	weapon_swap()
func weapon_swap(): 
	if Input.is_action_just_pressed("Debug"): 
		if current_wpn >= 2: current_wpn = 0
		else: current_wpn += 1
		set_weapon(weapon_loadout.get(current_wpn))
