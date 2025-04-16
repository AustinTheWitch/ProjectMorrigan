extends projectile

func _ready() -> void:
	damage = 4
	falloff = 0.0
	force = 1000
	can_be_warded = true
	initial_setup()
