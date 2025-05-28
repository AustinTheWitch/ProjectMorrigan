extends player_states
class_name player_ward

func enter() -> void:
	create_animation_id(character_id.weapon.wpn_name, "ward")
	character_id.perfect_ward = true
	print("warding")

func update(_delta: float) -> void:
	#set ward variable
	character_id.ward_up = Input.is_action_pressed("ward")
	#perfect ward timeout
	if character_id.animation_player.animation_finished: 
		character_id.perfect_ward = false
	#idle
	if !character_id.ward_up: state_change.emit(self, "idle")
	#run 
	if Input.get_axis("ui_left", "ui_right"): state_change.emit(self, "run")
	#blink
	if Input.is_action_just_pressed("blink"): state_change.emit(self, "blink")
	fall()

func exit() -> void: 
	character_id.ward_up = false
	player_previous_state = "ward"
	print("not warding")
