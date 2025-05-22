extends character_state
class_name player_states

static var player_direction: float
func enter() -> void: pass
func exit() -> void: pass
func update(_delta: float) -> void: pass
func physics_update(_delta: float) -> void: pass
#state swap functions
func idle() -> void: state_change.emit(self, "idle")

func run() -> void:
	player_direction = Input.get_axis("ui_left", "ui_right")
	state_change.emit(self, "run")

func ward() -> void: state_change.emit(self, "ward")

func attack() -> void: state_change.emit(self, "attack")
