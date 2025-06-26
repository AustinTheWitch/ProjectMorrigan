extends player_states
class_name player_windup
var charging: bool

func enter() -> void:
	print("WINDUP STATE")
	character_id.windup.start(2.0)
func update(_delta: float) -> void:
	#set windup variable
	charging = Input.is_action_pressed("weapon")
	#blink
	if Input.is_action_just_pressed("blink"): state_change.emit(self, "blink")
	#ward
	elif Input.is_action_pressed("ward"): state_change.emit(self, "ward")
	#attack
	elif character_id.atk_weight: state_change.emit(self, "attack")
	elif !charging: state_change.emit(self, "attack")

func physics_update(_delta: float) -> void: if !character_id.is_on_floor(): state_change.emit(self, "fall")
func exit() -> void:
	charging = false
	character_id.atk_ready = false
	character_id.attack.start(character_id.atk_speed)
