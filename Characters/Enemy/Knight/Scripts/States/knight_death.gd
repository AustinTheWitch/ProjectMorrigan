extends knight_state
class_name knight_death

func enter() -> void: 
	character_id.queue_free()
func update(_delta: float) -> void: pass
func physics_update(_delta: float) -> void: pass
func exit() -> void: pass
