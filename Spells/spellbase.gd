extends Area2D
class_name spell_base

#base stats
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
var damage: int
var speed: int = 10
var direction: float
var max_range: float = 1000.0
var distance: float = 0.0
var statuseffect: status_base

func _process(delta: float) -> void:
	spellcasted()
func spellcasted() -> void:
	position.x += direction * speed
	distance += speed
	if distance > max_range: 
		print("destroy object")
		queue_free()
func spawn(direct: float, start: Vector2) -> void:
	position = start
	direction = direct
func _on_body_entered(body: Node2D) -> void:
	if body is character_base:
		body.status_effects(self)
		print("enemy took damage")
		queue_free()
	else: print("no damage")
