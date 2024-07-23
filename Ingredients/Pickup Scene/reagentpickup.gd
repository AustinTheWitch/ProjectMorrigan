extends Area2D

var reagent_name: String = "Nothing"
var reagent: Reagent
@onready var reagent_sprite: AnimatedSprite2D = $ReagentSprite
func _ready():
	randomreagent()
func _process(_delta: float):
	pass
func randomreagent():
	reagent = Gamemanager.reagentlist.pick_random()
	reagent_name = reagent.reagent_name
	reagent_sprite.sprite_frames = reagent.reagent_sprite
	if !reagent: return
func pickedup(body: CharacterBody2D):
	if !body: return
	Gamemanager.inventory[reagent_name] += 1
	print(reagent_name)
	queue_free()
