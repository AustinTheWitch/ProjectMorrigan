extends Node2D
class_name weapon

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
var cur_combo: int
var combo_limit: int
#seperator comment
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _process(delta: float) -> void:
	ray_cast_2d.target_position.x = get_parent().direction * reach
	if Input.is_action_just_pressed("weapon"): attack_startup()
	if Input.is_action_just_released("weapon"): attack_finish(attack_string(heavy_atk, weapn_atk))

func attack_startup() -> void:
	melee = ray_cast_2d.is_colliding()
	heavy_atk = false
	windup.start(0.4)
	if cur_combo >= combo_limit: cur_combo = 0
	else: cur_combo += 1
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
	if damage.has(atk_id): return damage.get(atk_id)
	else:
		print("ATTACK DOES EXIST")
		return 0.0
func attack_finish(atk_id: String) -> void: 
	#if !animated_sprite_2d.sprite_frames.has_animation(atk_id): 
		#print("NO ANIM FOUND")
		#return
	#else: animated_sprite_2d.play(atk_id)
	combo.start(1.0)
	if ray_cast_2d.is_colliding() and animated_sprite_2d.animation_finished: apply_damage(atk_id)
	else: 
		print("ATTACK MISS")
		cur_combo = 0
func _on_combo_timeout() -> void: cur_combo = 0
