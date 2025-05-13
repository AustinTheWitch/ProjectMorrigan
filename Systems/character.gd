extends CharacterBody2D
class_name character

#nodes
@export var skeleton_2D: Skeleton2D
@export var collision_shape_2d: CollisionShape2D
@export var equipped_weapon: weapon_base
@export var animation_player: AnimationPlayer
@export var ui: base_ui
@export var ray_cast_2d: RayCast2D
#signals
signal damage_taken
#stats
var speed: float
var current_health: int
var max_health: int
#gravity
const GRAVITY: float = 980.0
func gravity(delta: float) -> void: if not is_on_floor(): velocity.y += GRAVITY * delta
#ward
var ward_up: bool
var perfect_ward: bool
#blink
@export var blink_timer: Timer
var blink_distance: float = 150.0
var blink_cooldown: float = 1.7
var blink_charges: int = 0
var max_charges: int = 1

func signal_connections() -> void: 
	damage_taken.connect(ui.update_healthbar)
