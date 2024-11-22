extends CharacterBody2D
class_name character_base
#character velocity
var speed: int
var force: int
var direction: Vector2
#character armor
var current_armor: int
var max_armor: int
#character health
var current_health: int
var max_health: int
#character damage output
var damage: int
#character sprite frames
var sprite_frames: SpriteFrames
#references
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	if not is_on_floor(): velocity.y += gravity * delta
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
