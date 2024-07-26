extends Control

@onready var page: VBoxContainer = $Page
@onready var reagent_name: Label = %Name
@onready var sprite: TextureRect = %Sprite
@onready var primary: Label = %Primary
@onready var secondary: Label = %Secondary
@onready var tertiary: Label = %Tertiary
@onready var description: RichTextLabel = %Description
var reagent: Reagent

func _ready():
	pass # Replace with function body.

func _process(_delta: float):
	pass
