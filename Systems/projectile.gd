extends RigidBody2D
class_name projectile_base

#projectile data
var projectile_name: String
var projectile_damage: float
var projectile_falloff: float
var projectile_force: float
var unblockable: bool
#alternative data
var status_effect: String
var area_effect: bool
var carry_amount: int
#stats
var direction: Vector2
#exports
@export var projectile_resource: PROJECTILE
#onready variables
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

func _ready() -> void: projectile_data(projectile_resource)
func _process(_delta: float) -> void: gravity_scale = projectile_falloff
func projectile_data(projectile: PROJECTILE) -> void:
	projectile_name = projectile.name
	projectile_damage = projectile.damage
	projectile_falloff = projectile.falloff
	projectile_force = projectile.force
	unblockable = projectile.unblockable
	if projectile is SPELL: 
		area_effect = projectile.area_effect
		status_effect = projectile.status_element
	elif projectile is PHYSICAL: carry_amount = projectile.amount_carried
	animated_sprite_2d.sprite_frames = projectile.sprite_frames
func apply_damage(body) -> void:
	var current_health = body.current_health
	var new_health = damage_formula(projectile_damage, current_health, body.ward_up, body.perfect_ward)
	body.damage_taken.emit(new_health, body.max_health)
	queue_free()
func damage_formula(damage: float, health: float, ward: bool, perfect_ward: bool) -> float:
	var ward_reduction: float
	if !ward or unblockable: ward_reduction = 0
	elif ward:
		if perfect_ward: 
			direction = -direction
			ward_reduction = damage
		else: ward_reduction = damage / 2
	return health - (damage - ward_reduction)
func _on_body_entered(body: Node) -> void:
	if body is character: apply_damage(body)
	else: queue_free()
func _on_timer_timeout() -> void: queue_free()
