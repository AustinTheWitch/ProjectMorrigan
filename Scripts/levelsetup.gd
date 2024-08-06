extends TileMap
@onready var reagent_folder: Node = $ReagentFolder
@onready var ingredient_locations: Array[Node2D]
var reagentpickup = preload("res://Ingredients/Pickup Scene/reagent_pickup.tscn")
@onready var camp_folder: Node2D = $CampFolder
@onready var camp_locations: Array[Node2D]
var campsite = preload("res://Scenes/camp.tscn")
func _ready():
	spawnloc()
	pickupspawn()
	campplacement()
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
func campplacement():
	for camp_spawns in camp_folder.get_children():
		if camp_spawns is Node2D:
			camp_locations.append(camp_spawns)
			var camps = campsite.instantiate()
			add_child(camps)
			camps.position = camp_spawns.position
