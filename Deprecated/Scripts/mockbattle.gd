extends Node

var game
var enemy: int
var player: int

var playerhealth = 10
var enemyhealth = 10
var playerdefense = -2
var enemydefense = -2

var hex: bool
var burn: bool

var burningtimer: Timer

func _ready():
	game = get_node("/root/Gamemanager")
	burningtimer = $Burning

func _process(_delta):
	_testcombat()

func _testcombat():
	if Input.is_action_just_pressed("Up"):
		hex = !hex
		print(hex)
	elif Input.is_action_just_pressed("Right"):
		var playdam = 3
		var burndam = 2
		var enemies = 4
		game._burneffect(burndam, enemydefense, burn)
		enemydefense = game.newdefense
		game._damagetaken(playdam, enemydefense)
		game._hexeffect(game.damagetaken, hex)
		game._healthupdate(game.damagetaken, enemyhealth)
		enemyhealth = game.newhealth
		print("Enemy health/defense is at " , enemyhealth , " / ", enemydefense, " Player hitting them for " , game.damagetaken)
	elif Input.is_action_just_pressed("Left"):
		var enemdam = 3
		var burndam = 2
		game._damagetaken(enemdam, playerdefense, hex)
		game._hexeffect(game.damagetaken, hex)
		game._burneffect()
		game._healthupdate(game.damagetaken, playerhealth)
		playerhealth = game.newhealth
		print("Player health is at" , playerhealth , " The enemy hitting them for " , game.damagetaken)
	elif Input.is_action_just_pressed("Down"):
		burn = !burn
		print(burn)
		if burn == true:
			burningtimer.start()
		else: pass
func _burning():
	burn = false
	burningtimer.stop()
	print(burn)
