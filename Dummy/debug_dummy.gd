extends character
@onready var p =  preload("res://Projectile/test_one/test_one.tscn")
@export var level_base: Node2D
@export var player_ref: character
var direction: Vector2


func _ready() -> void:
	health = 10
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Debug"): spawn_projectile()
func spawn_projectile() -> void:
	#direction
	direction = position.direction_to(player_ref.position)
	#instantiate
	var new_p = p.instantiate()
	new_p.direction = direction.normalized()
	add_child(new_p) #change this after testing to spawn on level
	print(new_p.direction)
