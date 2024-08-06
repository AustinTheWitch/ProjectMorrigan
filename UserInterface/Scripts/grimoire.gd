extends CanvasLayer

const FAMILIAR_PAGE = preload("res://UserInterface/familiarpage.tscn")
#@onready var familiar_section: TabContainer = $Background/Ch_Familiar
const Familiarpage = preload("res://UserInterface/Scripts/familiarpage.gd")

const REAGENT_PAGE = preload("res://UserInterface/reagentpage.tscn")
#@onready var reagent_section: TabContainer = $Background/Ch_Reagent
const Reagentpage = preload("res://UserInterface/Scripts/reagentpage.gd")

func _ready():
	#load_familiars()
	#reagent_index()
	#page_structure()
	pass
#func _process(_delta: float):
	#pass
#func load_familiars():
	#for familiar : Familiar in Gamemanager.familarlist:
		#var page : Familiarpage = FAMILIAR_PAGE.instantiate() as Familiarpage
		#page.familiar = familiar
		#page.name = familiar.familiar_name
		#familiar_section.add_child(page)
#
#func reagent_index():
	#for reagent : Reagent in Gamemanager.reagentlist:
		#var page : Reagentpage = REAGENT_PAGE.instantiate() as Reagentpage
		#page.reagent = reagent
		#page.name = reagent.reagent_name
		#reagent_section.add_child(page)
