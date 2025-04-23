extends weapon_base

var staff_weapon: WEAPON
var cur_weapon = 0
var debug_toggle: bool
func _ready() -> void: pass
func _process(delta: float) -> void:
	ray_cast_2d.target_position.x = get_parent().direction * reach
	if Input.is_action_just_pressed("Debug"): 
		debug_toggle = !debug_toggle
		cur_weapon = int(debug_toggle)
		active_wpn()
		print(weapn_atk)
	if Input.is_action_just_pressed("weapon"): attack_startup()
	if Input.is_action_just_released("weapon"): attack_finish(attack_string(heavy_atk, weapn_atk))


func active_wpn() -> void:
	if cur_weapon == 0: return
	elif cur_weapon == 1:
		print("weapon found")
		staff_weapon = preload("res://Testing/staff.tres")
		damage = staff_weapon.wpn_damage
		reach = staff_weapon.wpn_reach
		animated_sprite_2d.sprite_frames = staff_weapon.wpn_spriteframes
		weapn_atk = staff_weapon.wpn_id
