extends player_states
class_name player_deflect

@export var deflect: Timer

func enter() -> void: 
	character_id.defense_type = "deflecting"
	deflect.start(0.5)
	print("DEFLECT STATE")
func update(_delta: float) -> void:
	warding = Input.is_action_pressed("ward")
	if !warding: state_change.emit(self, "idle")
func physics_update(_delta: float) -> void: if !character_id.is_on_floor(): state_change.emit(self, "fall")
func exit() -> void: 
	deflect.stop()
	player_previous_state = "deflect"
func _on_deflect_timeout() -> void: 
	state_change.emit(self, "ward")
