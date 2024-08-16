extends Control

@onready var familiarpage: VBoxContainer = $"Page"
var familiar: Familiar
@onready var name_label: Label = %Name
@onready var familiar_sprite: TextureRect = %FamiliarSprite
@onready var about: RichTextLabel = %About
func _ready():
	pagesetup()
func pagesetup():
	if not is_instance_valid(familiar): return
	name_label.text = familiar.familiar_name
	familiar_sprite.texture = familiar.book_sprite
	about.text = familiar.description
func summon_button():
	Gamemanager.player_ref.summon_familiar(familiar)
