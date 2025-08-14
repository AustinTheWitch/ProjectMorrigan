extends game_element
class_name familiar_ui

@onready var progress_bar: ProgressBar = $ProgressBar

func update_familiar(charges_left: int, max_charges: int) -> void:
	progress_bar.value = charges_left
	progress_bar.max_value = max_charges
