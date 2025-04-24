extends RigidBody2D
class_name projectile

#damage
var damage: float
#physics
var direction: Vector2
var falloff: float
var force: float
#ward
var can_be_warded: bool

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
		print(incoming_damage)
	queue_free()
func _on_body_entered(body: Node) -> void:
	print(body)
	if body is character: apply_damage(body)
	else: queue_free()
