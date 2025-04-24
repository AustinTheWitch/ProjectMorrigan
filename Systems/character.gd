extends CharacterBody2D
class_name character

#nodes
@export var animated_sprite_2d: Sprite2D
@export var collision_shape_2d: CollisionShape2D

#stats
var speed: float
var health: int
#gravity
const GRAVITY: float = 980.0
func gravity(delta: float) -> void: if not is_on_floor(): velocity.y += GRAVITY * delta
#ward
@export var ward: Timer
var ward_up: bool
var perfect_ward: bool
