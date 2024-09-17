extends Node2D
@onready var reagent_folder: Node = $ReagentFolder
@onready var ingredient_locations: Array[Node2D]
var reagentpickup = preload("res://Ingredients/Pickup Scene/reagent_pickup.tscn")
@onready var camp_folder: Node2D = $CampFolder
@onready var camp_locations: Array[Node2D]
var campsite = preload("res://Camp_Bonfire/camp.tscn")
func _ready():
	spawnloc()
	pickupspawn()
func _process(_delta: float):
	pass
func spawnloc():
	for ingredient_loc in reagent_folder.get_children():
		if ingredient_loc is Node2D:
			ingredient_locations.append(ingredient_loc)
func pickupspawn():
	ingredient_locations.shuffle()
	for i in 3:
		var pickup = reagentpickup.instantiate()
		add_child(pickup)
		pickup.position = ingredient_locations[i].position
