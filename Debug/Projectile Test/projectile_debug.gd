extends Node2D
@onready var p =  preload("res://Systems/Projectile/projectile.tscn")
@export var level_base: Node2D
@export var player_ref: character

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Debug"): spawn_projectile()
func spawn_projectile() -> void:
	var new_p = p.instantiate()
	new_p.direction = player_ref.position
	add_child(new_p) #change this after testing to spawn on level
	
