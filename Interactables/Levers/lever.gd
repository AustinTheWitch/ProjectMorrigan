extends interactable

@export var interaction_target: interactable
#func interaction() -> void: 
	#if Input.is_action_just_pressed("interact") and in_range:
		#interaction_target.interacted = !interaction_target.interacted
