extends CanvasLayer

const FAMILIAR_PAGE = preload("res://UserInterface/familiarpage.tscn")
@onready var familar_section: TabContainer = $AspectRatioContainer/Ch_Familiar
const Familiarpage = preload("res://UserInterface/Scripts/familiarpage.gd")
func _ready():
	load_familiars()
func _process(delta: float):
	pass
func load_familiars():
	for familiar : Familiar in Gamemanager.familarlist:
		var page : Familiarpage = FAMILIAR_PAGE.instantiate() as Familiarpage
		page.familiar = familiar
		page.name = familiar.familiar_name
		familar_section.add_child(page)
		self.visible = false
