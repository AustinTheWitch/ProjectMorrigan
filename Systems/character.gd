extends CharacterBody2D
class_name character

#nodes
@export var sprite: Node2D
@export var animation_player: AnimationPlayer
@export var health_bar: health_element
#signals
signal update_health
signal update_healing

#stats
var speed: float
var current_health: float
var max_health: float
#gravity
const GRAVITY: float = 980.0 #Default Value - 980.0 ; Custom Value - 175.0
#ward
var defense_type: String
#blink
var blink_distance: float #Default Value = 250.0
#weapon
var weapon: weapon_base
var atk_string: String
var atk_number: int = 0
#familiar
var familiar: familiar_base
