extends CharacterBody2D
class_name character_base
#base stats
var speed: int
var direction: Vector2
var current_armor: int
var current_health: int
var max_armor: int
var max_health: int
var damage: int

#status effects
enum status
{
	cursed, frozen, burning, charged
}
#references
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var burning: Timer = $Burning
@onready var cursed: Timer = $Cursed

func status_effects() -> void:
	pass

func apply_damage() -> void:
	current_health = damage + current_armor
