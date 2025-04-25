extends RigidBody2D
class_name projectile_base

#damage
var damage: float
#physics
var direction: Vector2
var falloff: float
var force: float
#ward
var can_be_warded: bool
#attack id
var attack_id: String
#despawn time
@onready var timer: Timer = $Timer
#load resource
@export var projectile_type: PROJECTILE
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _process(delta: float) -> void: apply_central_force(direction)
func initial_setup() -> void:
	direction *= force
	gravity_scale = falloff
func apply_damage(body) -> void:
	if !can_be_warded: body.health = body.health - damage
	else:
		var incoming_damage
		if body.perfect_ward: 
			incoming_damage = 0
			direction = -direction
			set_collision_mask_value(1, true)
			set_collision_mask_value(5, true)
			return
		elif body.ward_up: incoming_damage = damage / 2.0
		else: incoming_damage = damage
		body.health = body.health - incoming_damage
	queue_free()
func _on_body_entered(body: Node) -> void:
	print(body)
	if body is character: apply_damage(body)
	else: queue_free()
func _on_timer_timeout() -> void: queue_free()
func setup_projectile() -> void:
	attack_id = projectile_type.projectile_id
	sprite_2d.sprite_frames = projectile_type.projectile_frames
	damage = projectile_type.projectile_damage.get(attack_id)
	force = projectile_type.projectile_force
	falloff = projectile_type.projectile_falloff
	can_be_warded = projectile_type.ward_check
