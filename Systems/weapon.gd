extends Node2D
class_name weapon_base

#exports
@export var wpn_holder: character
@export var wpn_resource: WEAPON
#on ready variables
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var area_2d: Area2D = $Sprite2D/Area2D
#weapon data
var damage: Dictionary[String, float]
var weapn_reach: float
var weapn_speed: float
var projectile_resource: PROJECTILE
var can_be_warded: bool
#boolean to state if weapon is melee or ranged | player determines this by proximity to enemy automatically
var melee_weapon: bool
#heavy attack
@onready var windup: Timer = $Windup
var heavy_atk: bool
#attack string
@onready var attack_reset: Timer = $"Attack Reset"
var attack_string: int = 0
var attack_limit: int = 3
func _ready() -> void:
	ray_cast_2d.set_collision_mask_value(set_mask(), true)
	set_weapon(wpn_resource)
#detection function
func set_mask() -> int:
	if get_parent() is player: return 5
	elif get_parent() is enemy: return 1
	else: return 0
func set_weapon(wpn_resource: WEAPON):
	weapn_speed = wpn_resource.wpn_speed
	weapn_reach = wpn_resource.wpn_reach
	damage = wpn_resource.damage_dict
	projectile_resource = wpn_resource.projectile_resource
	if wpn_holder is not player: melee_weapon = wpn_resource.wpn_type
	can_be_warded = wpn_resource.can_be_warded
func attack_id(atk_type: bool, atk_weight: bool, atk_number: int) -> String:
	var atk_id: String
	#check weight
	if atk_weight: atk_id += "heavy"
	else: atk_id += "light"
		#check type
	if atk_type: atk_id += "melee"
	else: atk_id += "ranged"
	#pull number in atk string
	#atk_id += str(atk_number)
	print(atk_id)
	return atk_id
func attack_startup(atk_id: String) -> float:
	#emit attacking signal and start attack anim
	#wpn_holder.emit("attacking")
	if !wpn_holder.animation_player.get_animation_list().has(atk_id): print("NO ATTACK ANIM FOUND")
	else: wpn_holder.animation_player.play(atk_id)
	#set damage for attack
	var atk_damage: float
	if damage.has(atk_id): atk_damage = damage.get(atk_id)
	else: atk_damage = 0.0
	return atk_damage
func attack_finish(atk_type: bool, atk_damage: float) -> void:
	if atk_type: melee(atk_damage)
	else: ranged(atk_damage)
func melee(atk_damage: float) -> void:
	area_2d.set_collision_mask_value(set_mask(), true)
	await wpn_holder.animation_player.animation_finished
	area_2d.set_collision_mask_value(set_mask(), false)
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is character: print("hit enemy")
func ranged(atk_damage: float): pass

#func attack_startup() -> void:
	#melee = ray_cast_2d.is_colliding()
	#heavy_atk = false
	#windup.start(0.4)
	#if cur_combo >= combo_limit: cur_combo = 0
	#else: cur_combo += 1
	#debug.start(weapn_speed)
#func _on_windup_timeout() -> void: heavy_atk = true
#func _on_combo_timeout() -> void: cur_combo = 0
#func attack_string(atk_weight: bool, atk_type: bool, hit_num: int) -> String: 
	#var atk_string: String
	##check attack weight
	#if !atk_weight: atk_string += "light"
	#else: atk_string += "heavy"
	##check attack type
	#if atk_type: atk_string += "melee"
	#else: atk_string += "ranged"
	##atk_string += wpn_id + str(hit_num)
	#return atk_string #attack id for anims and damage checks
	#print(atk_string)
#func attack_intermission(atk_id: String) -> void:
	##checking atk string
	##wpn_holder.emit("attacking")
	#if atk_id.contains("melee"): melee_finish(atk_id)
	#else: print("ranged attack") #spawn weapon's projectile
#func melee_finish(atk_id) -> void:
	##play attack string anim
	#if !animated_sprite_2d.sprite_frames.has_animation(atk_id): print("NO ANIM FOUND")
	#else: animated_sprite_2d.play(atk_id)
	##await animated_sprite_2d.animation_finished
	#var atk_damage: float
	#if damage.has(atk_id): atk_damage = damage.get(atk_id)
	#else: 
		#atk_damage = 0.0
		#print("ATTACK DOES NOT EXIST")
	#apply_damage(atk_damage)
#func apply_damage(atk_damage: float) -> void: 
	#if ray_cast_2d.is_colliding(): print("ATTACK HIT: " + str(atk_damage) + " damage")
	#else: print("ATTACK MISSED: 0.0 damage")
