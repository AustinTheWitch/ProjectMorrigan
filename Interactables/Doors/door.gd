extends interactable
class_name door

@onready var static_body_2d: StaticBody2D = $door_sprite/StaticBody2D

func _ready() -> void: interact_name = "door"

#func interaction() -> void:
	#static_body_2d.set_collision_layer_value(2, !interacted)
	#if Input.is_action_just_pressed("interact") and in_range:
		#if lock: 
			#print("DOOR LOCKED")
			#if key == null: print("ASSIGN A KEY")
		#else: interacted = !interacted
		#print(interacted)
