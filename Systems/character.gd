extends CharacterBody2D
class_name character

#nodes
@export var sprite: Node2D
@export var weapon: weapon_base
@export var animation_player: AnimationPlayer
@export var ui: base_ui
#signals
signal damage_taken
#stats
var speed: float
var current_health: int
var max_health: int
#gravity
const GRAVITY: float = 980.0 #Default Value - 980.0 ; Custom Value - 175.0
#ward
var warding: bool
var deflecting: bool
#blink
var blink_distance: float #Default Value = 250.0

func signal_connections() -> void: 
	damage_taken.connect(ui.update_healthbar)
