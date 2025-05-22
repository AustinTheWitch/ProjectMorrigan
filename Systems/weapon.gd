extends Node2D
class_name weapon_base
#exports
@export var wpn_user: character
@export var wpn_resource: WEAPON
#onready variables
@onready var area_2d: Area2D = $Sprite/Area2D
@onready var sprite_2d: Sprite2D = $Sprite/Sprite2D
#weapon data
var wpn_name: String
var wpn_damage: Dictionary[String, float]
var unblockable: bool

func weapon_data(weapon: WEAPON) -> void:
	wpn_name = weapon.weapon_name
	wpn_damage = weapon.weapon_damage
	unblockable = weapon.unblockable
	sprite_2d.texture = weapon.weapon_texture
	wpn_user.animation_player.get_animation_library(wpn_name)

func attack_string(atk_weight: bool, atk_number: int) -> String:
	var atk_id: String
	if atk_weight: atk_id += "heavy"
	else: atk_id += "light"
	if atk_number > 3: atk_number = 0
	else: atk_number += 1
	atk_id += str(atk_number)
	return atk_id

func apply_damage(body: Node2D, damage_data: float) -> void:
	var base_damage: float = damage_data
	var current_health: float = body.current_health
	var new_health = damage_formula(body.ward_up, body.perfect_ward, base_damage, current_health)
	body.damage_taken.emit(new_health, body.max_health)

func damage_formula(ward: bool, perfect_ward: bool, damage_value: float, target_health: float) -> float:
	#ward damage check
	var ward_reduction: float
	if !ward or unblockable: ward_reduction = 0
	elif ward: 
		if perfect_ward: ward_reduction = damage_value
		else: ward_reduction = damage_value / 2
	#applying the damage formula and modifiers
	print(target_health - (damage_value - ward_reduction))
	return target_health - (damage_value - ward_reduction)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if !body is character: return
	apply_damage(body, 0)
