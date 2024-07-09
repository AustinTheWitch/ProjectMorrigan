extends Node

var damageoutput: int
var newhealth: int
var newdefense: int
var blinkcharges: int
var familiarpos: Vector2
var familiarsanim: SpriteFrames


#Damage Functions---------------------------------------------------------------
func damagetaken(damage: int, defense: int):
	damageoutput = defense + damage

func healthupdate(damagedealt: int, health: int):
	newhealth = health - damagedealt

func hexeffect(damage: int, hexcheck: bool):
	if hexcheck == true:
		damageoutput = damage * 2
		print("Are you checking?")
	else: damageoutput = damage * 1

func burneffect(burndamage: int, defense: int, burncheck: bool):
	if burncheck == true and defense < 0:
		newdefense = burndamage + defense
	else: pass

func shockdamage(enemycount: int, damage: int, defense: int):
	var currentdamage: int
	currentdamage = damage * enemycount
	damageoutput = defense + currentdamage
#Spell Data---------------------------------------------------------------------

#Familiar System----------------------------------------------------------------
func selectedfam(name: String):
	call(name)
func godot():
	blinkcharges = 2
	newdefense = 2
	familiarpos = Vector2(-16, 19)
	familiarsanim = load("res://Art/SpriteFrames/TestFamiliar.tres")
	print("Random Familiar")
func othergodot():
	blinkcharges = 1
	newdefense = 5
	familiarpos = Vector2(-16, -19)
	familiarsanim = load("res://Art/SpriteFrames/TestFamiliar.tres")
	print("Other One")
