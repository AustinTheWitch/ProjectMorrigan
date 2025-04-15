extends RigidBody2D
class_name projectile

@export var player_ref: character

var damage: int
var direction: Vector2
var falloff: float
var force: float

func _ready() -> void: 
	damage = 1
	force = 100
	falloff = 0.0
	direction = Vector2(-1000, 0)
	gravity_scale = falloff
	pass

func _process(delta: float) -> void: pro_motion()
func pro_motion() -> void: apply_central_force(direction)

func apply_damage(body) -> void:
	body.health -= damage
	queue_free()

func _on_body_entered(body: Node) -> void:
	print(body)
	if body is character: apply_damage(body)
	else: queue_free()
