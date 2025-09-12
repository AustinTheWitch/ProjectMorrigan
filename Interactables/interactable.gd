extends Area2D
class_name interactable

@export var lock: bool
@export var animation: String

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
static var interact_state: bool

func _ready() -> void:
	if collision_shape_2d == null: 
		print("NO COLLISION BOX DETECTED OR FOUND. ADD OR ASSIGN ONE")
		return
func _on_body_entered(body: Node2D) -> void: 
	print("here")
	body.interact = self
func _on_body_exited(body: Node2D) -> void: 
	print("left")
	body.interact = null
func interaction() -> void: print("NO INTERACTION FUNC SETUP")
