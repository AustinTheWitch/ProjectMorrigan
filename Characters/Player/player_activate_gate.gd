extends player_states
class_name player_activate_gate
func enter() -> void: 
	print("ACTIVATING WITCH GATE STATE")
func update(_delta: float) -> void:
	interact.interaction()
	#character_id.animation_player.play("activate_gate")
	state_change.emit(self, "idle")
func physics_update(_delta: float) -> void: pass
func exit() -> void: pass
