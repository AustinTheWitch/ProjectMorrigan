extends character_state
class_name player_states

static var player_previous_state: String
static var interact: interactable
func enter() -> void: pass
func update(_delta: float) -> void: pass
func physics_update(_delta: float) -> void: pass
func exit() -> void: pass
func interaction_check() -> void:
	interact = character_id.interact
	if interact is door: state_change.emit(self, "door")
	elif interact is lever: state_change.emit(self, "lever")
	elif interact is hexgate: 
		if interact.inactive: state_change.emit(self, "activate_gate")
		else: state_change.emit(self, "use_gate")
	elif interact is pickup: state_change.emit(self, "pickup")
	else: print("CLASS NOT DEFINED OR FOUND")
