extends Area2D

#Base variables-------------------------------------------------------------------------------------
var player
var spellspeed = 650
var direction = Vector2(0, 0)
var spellsprite
#Single Target variables----------------------------------------------------------------------------
var damage = 0
var projectilecollision
#Area of Effect variables---------------------------------------------------------------------------
var aoedamage = 0
var aoecheck = false
var areaeffect
var areacollision

func _ready():
	player = get_node("/root/Player")
	aoecheck = false
	spellsprite = $AnimSprite
	areaeffect = $AreaTimer
	projectilecollision = $ProjectileShape
	areacollision = $AreaShape

func _process(_delta):
	position += direction.normalized() * spellspeed * _delta

func _hexcheck():
	if player.target == player.hexvictim and player.hexed == true:
		player.damage = player.damage * 2

func _impact(_area):
	print(_area)
	player.target = _area
	_hexcheck()
	player._hitmarker()
	player.target = null
	_areaeffect()

func _areaeffect():
	if aoecheck == true:
		spellspeed = 0
		spellsprite.play("areaeffect")
		projectilecollision.disabled = aoecheck
		areacollision.disabled != aoecheck
		print("AoE")
	else: queue_free()
