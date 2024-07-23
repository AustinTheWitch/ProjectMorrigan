extends TileMap
@onready var ingredient_locations: Array[Vector2]
@onready var position_one: Node2D = $IngredientLoc
@onready var position_two: Node2D = $IngredientLoc2
@onready var position_three: Node2D = $IngredientLoc3
var reagentpickup = preload("res://Ingredients/Pickup Scene/reagent_pickup.tscn")
func _ready():
	ingredient_locations.append(position_one.position)
	ingredient_locations.append(position_two.position)
	ingredient_locations.append(position_three.position)
	pickupspawn()
func _process(_delta: float):
	pass
func pickupspawn():
	var pickup_one = reagentpickup.instantiate()
	pickup_one.position = ingredient_locations[0]
	add_child(pickup_one)
	
	var pickup_two = reagentpickup.instantiate()
	pickup_two.position = ingredient_locations[1]
	add_child(pickup_two)
	
	var pickup_three = reagentpickup.instantiate()
	pickup_three.position = ingredient_locations[2]
	add_child(pickup_three)
