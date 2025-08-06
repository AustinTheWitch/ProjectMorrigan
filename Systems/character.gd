extends CharacterBody2D
class_name character

#nodes
@export var sprite: Node2D
@export var animation_player: AnimationPlayer
@export var health_bar: health_element
#signals
signal update_health
signal familiar_heal
signal damage_taken

#stats
var speed: float
var current_health: float
var max_health: float
#gravity
const GRAVITY: float = 980.0 #Default Value - 980.0 ; Custom Value - 175.0
#ward
var warding: bool
var deflecting: bool
#blink
var blink_distance: float #Default Value = 250.0
#weapon
var weapon: weapon_base
var atk_type: bool = false
var atk_number: int = 0
var attacking: bool = false
#familiar
var familiar: familiar_base
func attack_data() -> String:
	var attack: String
	if atk_type: attack = "heavy"
	else: attack = "light"
	attack += var_to_str(atk_number)
	return attack
