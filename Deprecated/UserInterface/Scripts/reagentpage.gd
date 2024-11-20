extends Control

@onready var page: VBoxContainer = $"Page"
@onready var reagent_name: Label = %Name
@onready var sprite: TextureRect = %Sprite
@onready var primary: Label = %Primary
@onready var secondary: Label = %Secondary
@onready var tertiary: Label = %Tertiary
@onready var description: RichTextLabel = %Description
var reagent: Reagent

func _ready():
	pagesetup()
func pagesetup():
	if not is_instance_valid(reagent): return
	reagent_name.text = reagent.reagent_name
	sprite.texture = reagent.reagent_book_sprite
	primary.text = reagent.reagent_tags[0]
	secondary.text = reagent.reagent_tags[1]
