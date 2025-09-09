extends player_states
class_name player_deflect

func enter() -> void: 
	#set deflect variable
	character_id.deflecting = true
	character_id.deflect.start(0.5)
	print("DEFLECT STATE")

func update(_delta: float) -> void:
	#set ward variable
	character_id.warding = Input.is_action_pressed("ward")
	#idle
	if !character_id.warding: state_change.emit(self, "idle")
	#ward
	if !character_id.deflecting and character_id.warding: state_change.emit(self, "ward")

func physics_update(_delta: float) -> void:
	#fall
	if !character_id.is_on_floor(): state_change.emit(self, "fall")

func exit() -> void:
	character_id.deflecting = false
	player_previous_state = "deflect"
