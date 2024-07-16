extends Area2D

var speed = 200
var screen_size
var cursor
var blinkreach
var target #Enemy Selected
var direction
#Blink variables------------------------------------------------------------------------------------
var blinkready
var blinkcooldown
var directionselected
#Attack variables-----------------------------------------------------------------------------------
var deflectready
var deflectcooldown
var deflectrange
var attackready
var attackcooldown
var energyblast
#Health/Damage variables----------------------------------------------------------------------------
var health
var maxhealth = 10
var damagetaken = 0
var damage = 0
var aoedamage = 0
var hit = false
var incomingdamage = 0
#Grimoire variables---------------------------------------------------------------------------------
var grimoire
var incantation
var incantating
var incantationcharge = 0
var incantationfinish
#Hex variables--------------------------------------------------------------------------------------
var hexed
var hextimer
var spellrange
var hexvictim
#Fireball variables---------------------------------------------------------------------------------
var fireball
var burndamage = 0
var fireballcooldown
var fireballready
var meltingshot

func _ready():
	screen_size = get_viewport_rect().size
	attackcooldown = $AttackCooldown
	blinkcooldown = $Blink
	blinkreach = $BlinkReach
	deflectcooldown = $DeflectCooldown
	deflectrange = $DeflectArea
	hextimer = $HexCountdown
	spellrange = $SpellRange
	incantation = $Incantation
	fireballcooldown = $FireballCooldown
	energyblast = preload("res://Scenes/projectile.tscn")
	
	grimoire = get_node("/root/Grimoire")
	blinkready = true
	attackready = true
	deflectready = true
	fireballready = true
	health = maxhealth
	directionselected = false
	hexed = false
	hexvictim = null
	incantating = false
	incantationfinish = false

func _process(_delta):
	_movement()
	_blink()
	_combat()
	_fireballtell()
	#print(incantation.time_left)
	
func _movement():
	var velocity = Vector2.ZERO
	direction = Vector2.ZERO
	directionselected = false
	if Input.is_action_pressed("Left"):
		velocity.x -= 1
		direction.x = -1
		directionselected = true
	if Input.is_action_pressed("Right"):
		velocity.x += 1
		direction.x = 1
		directionselected = true
	if Input.is_action_pressed("Up"):
		direction.y = -1
		directionselected = true
	if Input.is_action_pressed("Down"):
		direction.y = 1
		directionselected = true
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * get_process_delta_time()
	position = position.clamp(Vector2.ZERO, screen_size)

func _blink():
	cursor = get_local_mouse_position()
	blinkreach.set_target_position(position + 50 * direction)
	deflectrange.global_position = blinkreach.target_position
	if Input.is_action_just_pressed("Blink") and blinkready == true:
		if directionselected == false:
			direction = Vector2(-1, 0)
		position = position + 375 * direction.normalized()
		blinkcooldown.start(0)
		blinkready = false

func _blinkTimeout():
	blinkready = true
	print ("Blink Ready")
	blinkcooldown.stop()

func _combat():
	if Input.is_action_just_pressed("Attack"):
		if attackready == true:
			_attack()
	if Input.is_action_just_pressed("Deflect"):
		if deflectready == true:
			_deflect()
	if Input.is_action_just_pressed("Hex"):
		_hex()
	if Input.is_action_just_pressed("Fireball"):
		if fireballready == true:
			incantating = true
			incantationfinish = false
			incantation.start()
	if Input.is_action_just_released("Fireball"):
		if fireballready == true:
			incantating = false
			incantation.set_paused(true)
			_fireball()

func _deflect():
		print("Deflect")
		print(target)
		deflectcooldown.start()
		deflectready = false

func _deflectTimeout():
	deflectready = true
	deflectcooldown.stop()
	print("Deflect ready")

func _deflectInRange(_object):
	target = _object

func _deflectOutRange(_object):
	target = null

func _attack():
	if directionselected == false:
		direction = Vector2(1, 0)
	damage = 3
	burndamage = 0
	attackcooldown.start()
	attackready = false

func _attackTimeout():
	attackready = true
	attackcooldown.stop()
	print("Attack ready")

#Damage/Health--------------------------------------------------------------------------------------
func _hitmarker():
	if meltingshot == true:
		target.burning = true
		meltingshot = false
	else: target.burndefense = burndamage
	target.incomingdamage = damage
	target._damagetaken()

func _health():
	var healthupdate = get_node("/root/PlayerUi")
	healthupdate.health.value = health
	if health <= 0:
		print("Player Died")

func _damagetaken():
	damagetaken = 2 + -1 #Enemy/BossDamage + Armor Value
	health = health - damagetaken
	_health()
#Grimoire-------------------------------------------------------------------------------------------
func _hex():
	spellrange.global_position = position
	spellrange.target_position = position * 200 * direction
	target = spellrange.get_collider()
	if target != null:
		hexed = true
		hextimer.start(10.0)
		print("Hex is on")
		hexvictim = target
		print (hexvictim)

func _hextimedout():
	print("Hex is over")
	hextimer.stop()
	hexed = false

func _fireball(): #Add AoE effect and create fireball scene
	if directionselected == false:
		direction = Vector2(1, 0)
	if incantationcharge > 5.0 or incantationfinish == true:
		damage = 1
		burndamage = 1
		fireballcooldown.set_wait_time(1.0)
		fireballcooldown.start()
		fireballready = false
		incantation.set_paused(false)
		incantation.stop()
		incantating = false
		print("No Charge")
	elif incantationcharge < 5.0 and incantationcharge > 2.1:
		print("Mid Charge")
		damage = 0
		burndamage = 0
		incantation.set_paused(false)
		incantation.stop()
		fireballcooldown.set_wait_time(3.0)
		fireballcooldown.start()
		fireballready = false
		incantating = false
		meltingshot = true
	elif incantationcharge < 2.0:
		print("Explosion!!!")
		damage = 1
		burndamage = 0
		aoedamage = 99
		incantation.set_paused(false)
		incantation.stop()
		fireballcooldown.set_wait_time(6.0)
		fireballcooldown.start()
		fireballready = false
		incantating = false

func _fireballtell():
	var player = $AnimatedSprite2D
	if incantating == true:
		incantationcharge = incantation.get_time_left()
		player.rotation = incantationcharge
	else: player.rotation = 0

func _incantationtimedout():
	incantationfinish = true
	incantating = false
	incantation.stop()

func _fireout():
	fireballready = true
	fireballcooldown.stop()
#Familiars------------------------------------------------------------------------------------------
