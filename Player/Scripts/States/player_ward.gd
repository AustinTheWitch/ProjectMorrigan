extends player_states
class_name player_ward

func enter() -> void:
	create_animation_id(character_id.weapon.wpn_name, "ward")
	character_id.perfect_ward = true
	print("warding")

func update(_delta: float) -> void:
	character_id.ward_up = Input.is_action_pressed("ward")
	if character_id.animation_player.animation_finished: 
		character_id.perfect_ward = false
	if !character_id.ward_up: 
		character_id.animation_player.play_backwards(animation_string)
		await character_id.animation_player.animation_finished
		state_change.emit(self, "idle")
	if Input.get_axis("ui_left", "ui_right"): state_change.emit(self, "run")
	fall()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("blink"): state_change.emit(self, "blink")
	elif event.is_action_pressed("weapon"): attack()

func attack() -> void: 
	character_id.ward_up = false
	character_id.perfect_ward = false
	character_id.atk_weight = false
	character_id.attack_windup.start(0.7)
	character_id.velocity = Vector2.ZERO
	state_change.emit(self, "attack")

func exit() -> void: 
	character_id.ward_up = false
	print("not warding")
