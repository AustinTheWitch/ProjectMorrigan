extends user_interface
#onready nodes
@onready var speaker: TextureRect = $"VN/NPC Sprite [Right]/Sprite"
@onready var player: TextureRect = $"VN/Player Sprite [Left]/Sprite"
@onready var speaking: Label = $VN/Dialogue_Here/Content_Box/Speaker
@onready var dialogue: RichTextLabel = $VN/Dialogue_Here/Content_Box/Dialogue
@onready var player_box: VBoxContainer = $"VN/Dialogue_Here/Decision Box [Keep Empty]"
#dialogue variables
var current_dialogue: vn_dialogue
var current_line: int
var on_last_line: bool
var next_scene: Array

func _ready() -> void:
	visible = false
func _process(delta: float) -> void: 
	pass 
func conversation_start(conversation: vn_dialogue) -> void:
	if not is_instance_valid(conversation): return
	get_tree().paused = true
	current_dialogue = conversation
	current_line = -1
	visible = true
	on_last_line = false
	for button in player_box.get_children():
		button.queue_free()
	next_scene = current_dialogue.scene_direction.keys()
	conversation_advance()
func conversation_advance() -> void:
	if on_last_line: return
	current_line += 1
	if current_line == current_dialogue.dialogue.size() - 1:
		dialogue_options()
		on_last_line = true
	speaker.texture = current_dialogue.speaker
	player.texture = current_dialogue.player
	speaking.text = current_dialogue.speaking[current_line]
	dialogue.text = current_dialogue.dialogue[current_line]
	pass
func on_dialogue_option_clicked(id: int) -> void:
	print("Conversation ended")
	converstation_end()
func on_dialogue_option_advancement(id: int) -> void:
	conversation_start(current_dialogue.scene_direction.get(next_scene[0]))
	next_scene = []
	for button in player_box.get_children():
		button.queue_free()
func converstation_end():
	visible = false
	get_tree().paused = false
	for button in player_box.get_children():
		button.queue_free()
func dialogue_options():
	for i in current_dialogue.player_input.size():
		var dialogue_option: Button = Button.new()
		player_box.add_child(dialogue_option)
		dialogue_option.text = current_dialogue.player_input[i]
		if !next_scene.is_empty() and dialogue_option.text == next_scene[0]:
			dialogue_option.pressed.connect(on_dialogue_option_advancement.bind(i))
			pass
		else: dialogue_option.pressed.connect(on_dialogue_option_clicked.bind(i))
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Advance Dialogue") and visible == true:
		get_viewport().set_input_as_handled()
		conversation_advance()
