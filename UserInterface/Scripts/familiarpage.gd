extends Control

@onready var control: Control = $"."
@onready var familiarpage: VBoxContainer = $"Page"
var resolution: Vector2
func _ready():
	uisetup()
func uisetup():
	resolution = get_viewport_rect().size
	control.size = resolution / 2
	print(resolution, control.size)
	pass
