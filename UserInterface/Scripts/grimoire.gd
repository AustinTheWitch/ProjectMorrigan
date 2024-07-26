extends CanvasLayer

const FAMILIAR_PAGE = preload("res://UserInterface/familiarpage.tscn")
@onready var familar_section: TabContainer = $AspectRatioContainer/Binding/Ch_Familiar
const Familiarpage = preload("res://UserInterface/Scripts/familiarpage.gd")

const REAGENT_PAGE = preload("res://UserInterface/reagentpage.tscn")
@onready var reagent_section: TabContainer = $AspectRatioContainer/Binding/Ch_Reagent
const Reagentpage = preload("res://UserInterface/Scripts/reagentpage.gd")

func _ready():
	load_familiars()
func _process(_delta: float):
	pass
func load_familiars():
	for familiar : Familiar in Gamemanager.familarlist:
		var page : Familiarpage = FAMILIAR_PAGE.instantiate() as Familiarpage
		page.familiar = familiar
		page.name = familiar.familiar_name
		familar_section.add_child(page)
		self.visible = false

func reagent_index():
	for reagent : Reagent in Gamemanager.reagentlist:
		var page : Reagentpage = REAGENT_PAGE.instantiate() as Reagentpage
		page.reagent = reagent
		page.name = reagent.reagent_name
