extends Node2D
class_name weapon_base
#exports
@export var wpn_user: character
@export var combo_reset: Timer
@export var sprite_2d: Sprite2D
@export var area_2d: Area2D
#weapon data
var wpn_name: String
var wpn_damage: Dictionary[String, float]
var ward_check: bool
#weapon checks
var atk_weight: bool
var atk_number: int
var mask_layers: Array[int]
#signal
signal attacking

func attack_string() -> String:
	var atk_id: String
	if atk_weight: atk_id += "heavy"
	else: atk_id += "light"
	atk_id += wpn_name
	if atk_number >= 3: atk_number = 0
	else: atk_number += 1
	atk_id += str(atk_number)
	return atk_id
func _on_area_2d_body_entered(body: Node2D) -> void: if body is character: apply_damage(body)
func apply_damage(body: Node2D) -> void:
	var damage = wpn_damage.get(attack_string())
	if !ward_check: 
		body.current_health = body.current_health - damage
		body.damage_taken.emit(body.current_health, body.max_health)
	else:
		if body.perfect_ward: damage *= 0
		elif body.ward_up: damage = damage / 2.0
		body.current_health = body.current_health - damage
		body.damage_taken.emit(body.current_health, body.max_health)
