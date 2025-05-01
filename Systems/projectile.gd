extends RigidBody2D
class_name projectile_base

#damage
var damage: float = 3
#physics
var direction: Vector2
var falloff: float
var force: float
#ward
var can_be_warded: bool = true
#attack id
var attack_id: String
#despawn time
@onready var timer: Timer = $Timer
#load resource
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@export var projectile_data: PROJECTILE
func _ready() -> void: setup_projectile(projectile_data)
func _process(delta: float) -> void: apply_central_force(direction)
func initial_setup() -> void:
	direction *= force
	gravity_scale = falloff
func apply_damage(body) -> void:
	if !can_be_warded: 
		body.current_health = body.current_health - damage
		body.damage_taken.emit(body.current_health, body.max_health)
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
		body.current_health = body.current_health - incoming_damage
		body.damage_taken.emit(body.current_health, body.max_health)
	queue_free()
func _on_body_entered(body: Node) -> void:
	print(body)
	if body is character: apply_damage(body)
	else: queue_free()
func _on_timer_timeout() -> void: queue_free()
func setup_projectile(prt_type: PROJECTILE) -> void:
	falloff = prt_type.falloff
