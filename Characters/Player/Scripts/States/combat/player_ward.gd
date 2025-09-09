extends player_states
class_name player_ward

func enter() -> void:
	print("WARD STATE")
	character_id.deflecting = false

func update(_delta: float) -> void:
	#set ward variable
	character_id.warding = Input.is_action_pressed("ward")
	#idle
	if !character_id.warding: state_change.emit(self, "idle")
	#blink
	if Input.is_action_just_pressed("blink"): state_change.emit(self, "blink")

func physics_update(_delta: float) -> void:
	#fall
	if !character_id.is_on_floor(): state_change.emit(self, "fall")

func exit() -> void: 
	character_id.warding = false
	player_previous_state = "ward"
	print("not warding")
