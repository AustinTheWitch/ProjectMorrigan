extends weapon_base

var staff_weapon: WEAPON
var cur_weapon = 0
var debug_toggle: bool
func _ready() -> void: 
	ray_cast_2d.set_collision_mask_value(set_mask(), true)
func _process(delta: float) -> void:
	ray_cast_2d.target_position.x = get_parent().direction * reach
	node_2d.position.x *= get_parent().direction
	if Input.is_action_just_pressed("Debug"): 
		debug_toggle = !debug_toggle
		cur_weapon = int(debug_toggle)
		active_wpn()
	if Input.is_action_just_pressed("weapon"): attack_startup()
	if Input.is_action_just_released("weapon"): 
		if melee: attack_finish(attack_string(heavy_atk, weapn_atk))
		else: ranged_attack()
func active_wpn() -> void:
	if cur_weapon == 0: return
	elif cur_weapon == 1:
		print("weapon found")
		staff_weapon = preload("res://Weapon/Types/staff.tres")
		damage = staff_weapon.wpn_damage
		reach = staff_weapon.wpn_reach
		animated_sprite_2d.sprite_frames = staff_weapon.wpn_spriteframes
		weapn_atk = staff_weapon.wpn_id
