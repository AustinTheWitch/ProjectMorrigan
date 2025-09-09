extends player_states
class_name player_windup

var charging: bool
@export var windup: Timer

func enter() -> void:
	print("WINDUP STATE")
	atk_weight = false
	atk_ready = false
	windup.start(3.0)
func update(_delta: float) -> void:
	#set windup variable
	charging = Input.is_action_pressed("weapon")
	#blink
	if Input.is_action_just_pressed("blink"): state_change.emit(self, "blink")
	#ward
	elif Input.is_action_pressed("ward"): state_change.emit(self, "ward")
	#commited attack
	if !charging: state_change.emit(self, "lightattack")
	
func physics_update(_delta: float) -> void: 
	if !character_id.is_on_floor(): state_change.emit(self, "fall")
	
func exit() -> void:
	windup.stop()
	
	character_id.attack.start(character_id.atk_speed)
	character_id.weapon.area_2d.set_collision_mask_value(6, true)
	player_previous_state = "windup"
func _on_windup_timeout() -> void: 
	atk_weight = true
	state_change.emit(self, "heavyattack")
