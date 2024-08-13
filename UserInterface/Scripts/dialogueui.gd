extends MarginContainer
@onready var speaker: TextureRect = $Speaking/Speaker
@onready var player: TextureRect = $Player/Player
@onready var speaking: Label = $Content_Here/Content_Box/Speaker
@onready var dialogue: RichTextLabel = $Content_Here/Content_Box/Dialogue
@onready var player_box: VBoxContainer = $Content_Here/Player_Box
@export var scene: Dialogue

func _ready():
	scene_setup()
	dialogue_options()

func dialogue_options():
	for i in scene.player_input.size():
		var dialogue_option: Button = Button.new()
		player_box.add_child(dialogue_option)
		dialogue_option.text = scene.player_input[i]

func scene_setup():
	if not is_instance_valid(scene): return
	speaker.texture = scene.speaker
	player.texture = scene.player
	speaking.text = scene.speaking[0]
	dialogue.text = scene.dialogue[0]
