extends Node

var damagetaken: int
var newhealth: int
var newdefense: int

#Damage Functions-----------------------------------------------------------------------------------
func _damagetaken(damage: int, defense: int):
	damagetaken = defense + damage

func _healthupdate(damagedealt: int, health: int):
	newhealth = health - damagedealt

func _hexeffect(damage: int, hexcheck: bool):
	if hexcheck == true:
		damagetaken = damage * 2
		print("Are you checking?")
	else: damagetaken = damage * 1

func _burneffect(burndamage: int, defense: int, burncheck: bool):
	if burncheck == true and defense < 0:
		newdefense = burndamage + defense
	else: pass

func _shockdamage(enemycount: int, damage: int, defense: int):
	var currentdamage: int
	currentdamage = damage * enemycount
	damagetaken = defense + currentdamage
#Spell Data-----------------------------------------------------------------------------------------
