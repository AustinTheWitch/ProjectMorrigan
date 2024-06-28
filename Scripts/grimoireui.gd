extends TabContainer

var player
var grimoireopen
var grimoiremenu

func _ready():
	player = get_node("/root/Player")
	grimoiremenu = self
	var spellbook = $Spells
	var familiarbook = $Familiars
	grimoireopen = false
	grimoiremenu.set_visible(false)

func _process(delta):
	_opengrimoire()

func _opengrimoire():
	if Input.is_action_just_pressed("Grimoire"):
		grimoireopen = !grimoireopen
		grimoiremenu.set_visible(grimoireopen)


