extends Control

var player
var health

func _ready():
	player = get_node("/root/Player")
	health = $Health
	health.max_value = player.maxhealth
	health.value = health.max_value
