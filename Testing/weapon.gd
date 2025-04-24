extends Node2D
class_name weapon_base

#damage values per attack
var damage: Dictionary[String, float]
#range detection
@onready var ray_cast_2d: RayCast2D = $RayCast2D
var melee: bool
var reach: float = 75.0
#weapon and attack type
@onready var windup: Timer = $Windup
var heavy_atk: bool
var weapn_atk: String
#combo
@onready var combo: Timer = $Combo
var cur_combo: int = -1
var combo_limit: int = 4
#animated sprite
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
#range attack
@onready var node_2d: Node2D = $Node2D
@onready var p =  preload("res://Projectile/projectile.tscn")


func attack_startup() -> void:
	melee = ray_cast_2d.is_colliding()
	heavy_atk = false
	windup.start(0.4)
	if cur_combo >= combo_limit: cur_combo = -1
	else: cur_combo += 1
	combo.start(1.0)
func _on_windup_timeout() -> void: heavy_atk = true
func attack_string(heavy_check: bool, wpn_check: String) -> String: 
	#check attack type
	var atk_type: String
	if heavy_check: atk_type = "heavy"
	else: atk_type = "light"
	#set attack string
	var attack = atk_type + wpn_check + str(cur_combo)
	return attack
func apply_damage(atk_id) -> float:
	if damage.has(atk_id): 
		print(atk_id + " " + str(damage.get(atk_id)))
		return damage.get(atk_id)
	else:
		print("ATTACK DOES EXIST" + " " + atk_id)
		return 0.0
func attack_finish(atk_id: String) -> void: 
	#if !animated_sprite_2d.sprite_frames.has_animation(atk_id): 
		#print("NO ANIM FOUND")
		#return
	#else: animated_sprite_2d.play(atk_id)
	if ray_cast_2d.is_colliding() and animated_sprite_2d.animation_finished: apply_damage(atk_id)
	else: 
		print("ATTACK MISS")
		cur_combo = 0
func _on_combo_timeout() -> void: cur_combo = -1
func range_attack() -> void: 
	#direction
	var direction = position.direction_to(ray_cast_2d.target_position)
	#instantiate
	var new_p = p.instantiate()
	new_p.direction = direction.normalized()
	new_p.position = ray_cast_2d.target_position
	add_child(new_p) #change this after testing to spawn on level
	print(new_p.direction)
func set_mask() -> int:
	if get_parent() is player: 
		print("player?")
		return 5
	else: 
		print("enemy?")
		return 1
