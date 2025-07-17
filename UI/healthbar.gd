extends game_element
class_name health_element

@onready var progress_bar: ProgressBar = $ProgressBar

func update_healthbar(cur_hp, max_hp):
	progress_bar.value = cur_hp
	progress_bar.max_value = max_hp
