extends Node2D
class_name weapon_base

#damage values per attack
var damage: Dictionary[String, float]
#range detection
@onready var ray_cast_2d: RayCast2D = $RayCast2D
var melee: bool
var weapn_reach: float
#weapon and attack type
@onready var windup: Timer = $Windup
var heavy_atk: bool
var weapn_name: String
#combo
@onready var debug: Timer = $Debug
@onready var combo: Timer = $Combo
var cur_combo: int = -1
var combo_limit: int = 4
var weapn_speed: float
#animated sprite
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
#range attack
#@onready var p =  preload("res://Projectile/projectile.tscn")
#var p_type: PROJECTILE

#detection function
func set_mask() -> int:
	if get_parent() is player: return 5
	else: return 1
func set_weapon(wpn_resource: WEAPON):
	weapn_name = wpn_resource.wpn_id
	animated_sprite_2d.sprite_frames = wpn_resource.wpn_spriteframes
	weapn_speed = wpn_resource.wpn_speed
	weapn_reach = wpn_resource.wpn_reach
	damage = wpn_resource.damage_dict
func attack_startup() -> void:
	melee = ray_cast_2d.is_colliding()
	heavy_atk = false
	windup.start(0.4)
	if cur_combo >= combo_limit: cur_combo = 0
	else: cur_combo += 1
	debug.start(weapn_speed)
func _on_windup_timeout() -> void: heavy_atk = true
func attack_string(heavy_check: bool, wpn_id: String) -> String: 
	#check attack type
	var atk_type: String
	if heavy_check: atk_type = "heavy"
	else: atk_type = "light"
	#set attack string | melee prefix = true / ranged prefix = false
	#example - truelightstaff2 = melee attack, light attack, staff wpn, second attack in combo
	var attack = str(melee) + atk_type + wpn_id + str(cur_combo)
	return attack
func melee_attack(atk_id) -> float:
	if damage.has(atk_id): 
		print(atk_id + " does " + str(damage.get(atk_id)) + " damage")
		return damage.get(atk_id)
	else:
		print("ATTACK DOES NOT EXIST" + " " + atk_id)
		return 0.0
#func ranged_attack() -> void:
	##direction
	#var direction = position.direction_to(ray_cast_2d.target_position)
	##instantiate
	#var new_p = p.instantiate()
	#new_p.position = ray_cast_2d.target_position
	#new_p.direction = direction.normalized()
	#new_p.set_collision_mask_value(set_mask(), true)
	#add_child(new_p) #change this after testing to spawn on level
func attack_finish(atk_id: String) -> void: 
	#input attack string
	#play attack string anim
	if !animated_sprite_2d.sprite_frames.has_animation(atk_id): print("NO ANIM FOUND")
	else: animated_sprite_2d.play(atk_id)
	#apply attack string damage on anim signal
	if animated_sprite_2d.animation_finished and ray_cast_2d.is_colliding(): 
		print("ATTACK HIT")
		combo.start(1.0)
		melee_attack(atk_id)
	else:
		print("ATTACK MISS")
		cur_combo = 0
func _on_combo_timeout() -> void: cur_combo = 0
