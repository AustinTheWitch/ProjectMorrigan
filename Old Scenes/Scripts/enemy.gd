extends Area2D

var speed = 250
var health = 10
var defense = -1
var damagetaken = 0
var damage = 0
var incomingdamage = 0
var attack
var target
var burndefense = 0
var burntimer
#Behavior-------------------------------------------------------------------------------------------
var los
var detected = false
var attackrange
var hit = false
var cursed = false
var burning = false

func _ready():
	burntimer = $BurnTimer

func _health():
	if health <= 0:
		print("Enemey Died")
		queue_free()

func _damagetaken():
	_burncheck()
	damagetaken = incomingdamage + (defense + burndefense) #(PlayerDamage + Armor Value)
	health = health - damagetaken
	_health()
	print(health)

func _burncheck():
	if burning == true:
		burntimer.start()
		burndefense = abs(defense)
	else: pass

func _burnout():
	burntimer.stop()
	burning = false
	print("Burning Effect Done")

func _hitplayer():
	target.incomingdamage = damage
	target._damagetaken()

func _normalattack():
	damage = 2
	_hitplayer()
	print("Enemy Attack")
