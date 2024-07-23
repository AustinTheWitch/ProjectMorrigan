extends Node

var damageoutput: int
var newhealth: int
var newdefense: int
var player_ref : player_scene

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
#familiar data------------------------------------------------------------------
const familarlist: Array[Familiar] = [preload("res://Familiars/Godot.tres"), 
preload("res://Familiars/OtherGodot.tres")]
#potionbrewing------------------------------------------------------------------
var inventory: Dictionary = {"Godot Shade": 0, "Random Reagent": 0
}
const reagentlist: Array[Reagent] = [preload("res://Ingredients/GodotShade.tres"), 
preload("res://Ingredients/RandomReagent.tres")]
