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

#references
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var burning: Timer = $Burning
@onready var cursed: Timer = $Cursed
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#status effects
var statuseffects: Array[status_base]

func status_effects(status: spell_base) -> void:
	statuseffects.append(status.statuseffect)
	apply_damage(status.damage)

func apply_damage(alt_damage: int) -> void:
	var total_damage = alt_damage
	for status in statuseffects:
		total_damage = status.modify_damage(total_damage)
	current_health = current_health - (current_armor + total_damage)

#gravity
func set_gravity(new_gravity: float) -> float:
	new_gravity = gravity
	velocity.y = new_gravity * get_process_delta_time()
	return velocity.y

func enemy_movement() -> void:
	pass

#sprite frames and anims
func set_sprites(sprite: SpriteFrames) -> SpriteFrames:
	animated_sprite_2d.sprite_frames = sprite
	return sprite
