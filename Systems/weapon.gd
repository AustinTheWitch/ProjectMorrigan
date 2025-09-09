extends Node2D
class_name weapon_base
#signal
signal attack_hit
#resource
@export var weapon: WEAPON
#onready variables
@onready var area_2d: Area2D = $Sprite/Area2D
@onready var sprite_2d: Sprite2D = $Sprite/Sprite2D
var user: character
#weapon data
var weapon_name: String
var weapon_attacks: Dictionary[String, float]
func _ready() -> void:
	user = get_parent().get_parent()
	weapon_load(weapon)
	user.weapon = self
func weapon_load(weapon_data: WEAPON) -> void:
	weapon_name = weapon_data.weapon_name
	weapon_attacks = weapon_data.weapon_attacks
func _on_area_2d_body_entered(body: Node2D) -> void:
	if !body is character: return
	
func damage_formula(body: Node2D, attack_string: String) -> float:
	return 1.0
