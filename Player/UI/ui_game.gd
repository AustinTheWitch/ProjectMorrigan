extends base_ui
class_name game_ui

@onready var progress_bar: ProgressBar = $Health/ProgressBar

func _ready() -> void: pass

func update_healthbar(cur_hp, max_hp):
	progress_bar.value = cur_hp
	progress_bar.max_value = max_hp
