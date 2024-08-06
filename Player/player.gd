extends CharacterBody2D
class_name player_scene
#Refs---------------------------------------------------------------------------
@onready var player: AnimatedSprite2D = $AnimSprite
@onready var raycast: RayCast2D = $RayCast2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#Stats--------------------------------------------------------------------------
var health: int = 10
var defense: int = -2
var damage: int = 2
var spelldamage: int
#Movement-----------------------------------------------------------------------
var direction: float = 1
var speed: int = 330
var movement: bool = false
#Jump---------------------------------------------------------------------------
var force: int = -300
var jumped: bool = false
#Blink--------------------------------------------------------------------------
@onready var blinkcooldown: Timer = $Blink
var potency: int = 475
var blinked: bool = false
var blinkcharges: int = 1
var currentcharge: int = 0
#Camera-------------------------------------------------------------------------
@onready var pov: Camera2D = $Camera2D
var bossroom: bool = false
#Familiar-----------------------------------------------------------------------
@onready var familiarsprite: AnimatedSprite2D = $FamiliarSprite
@onready var familiarincantation: Timer = $FamiliarIncantation
var summoning: bool = false
var familarname: Familiar
#Attack-------------------------------------------------------------------------
@onready var attackcharge: Timer = $AttackIncantation
#Attack Charge Tiers: X = Half Charge Cutoff, Y = Full Charge Cutoff
var attacktiers: Array[float] = [1.0, 2.0]
var attacklevel: int
var chargingattack: bool = false
#Camp---------------------------------------------------------------------------
var at_camp: bool = false
var resting: bool = false
#Grimoire-----------------------------------------------------------------------
var grimiore_open: bool = false

func _ready():
	Gamemanager.player_ref = self
func _process(_delta):
	open_grimoire()
	attackinput()
	campsystem()
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	playerjump()
	setdirection()
	blink()
	move_and_slide()
#set player jumping-------------------------------------------------------------
func playerjump():
	if Input.is_action_just_pressed("Up") and jumped == false:
		jumped = true
		move_and_collide(Vector2(0, force))
		#jump anim track here
	elif is_on_floor():
		jumped = false
		raycast.target_position.y = 0
#set player direction-----------------------------------------------------------
func setdirection():
	if Input.is_action_pressed("Right"):
		direction = 1
		velocity.x = direction * speed
		player.flip_h = false
		#movement anim track here
		movement = true
		summoning = false
		chargingattack = false
	elif Input.is_action_pressed("Left"):
		direction = -1
		velocity.x = direction * speed
		player.flip_h = true
		#movement anim track here
		movement = true
		summoning = false
		chargingattack = false
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		movement = false
		player.play("Idle")
#set player blink---------------------------------------------------------------
func blink():
	if Input.is_action_just_pressed("Blink") and blinked == false:
		currentcharge += 1
		if currentcharge >= blinkcharges: blinked = true
		var blink_direction = direction if movement or jumped else -direction
		move_and_collide(Vector2(potency * blink_direction, 0))
		#if movement == false:
		#	raycast.target_position.x = potency * direction * -1
		#	raycast.force_raycast_update()
		#	if raycast.is_colliding(): position.x = raycast.get_collision_point().x
		#	else: global_position.x = raycast.to_global(raycast.target_position).x
		#else: 
			#raycast.target_position.x = potency * direction
			#raycast.force_raycast_update()
			#if raycast.is_colliding(): position.x = raycast.get_collision_point().x
			#else: global_position.x = raycast.to_global(raycast.target_position).x
		print(potency * direction)
		print(currentcharge)
		blinkcooldown.start()
func blinktime():
	blinked = false
	if currentcharge <= 0:
		blinkcooldown.stop()
	else: currentcharge -= 1
	print(currentcharge)
#set camera---------------------------------------------------------------------
func playercam():
	pass
#familiar system----------------------------------------------------------------
func summon_familiar(familiar: Familiar):
	if summoning: return
	summoning = true
	familiarincantation.start()
	grimiore_open = false
	Grimoire.visible = grimiore_open
	await familiarincantation.timeout or !summoning
	if !summoning: familiarincantation.stop()
	else:
		blinkcharges = familiar.blink_charge_bonus
		defense = familiar.defense_bonus
		familiarsprite.position = familiar.position
		familiarsprite.sprite_frames = familiar.anim_frames
		print(defense, " and ", blinkcharges)
		summoning = false
#attack system------------------------------------------------------------------
func attackinput():
	if Input.is_action_just_pressed("Attack"):
		attackstart()
	if Input.is_action_just_released("Attack"):
		attackfinish(false)
func attackstart():
	attackcharge.start()
	chargingattack = true
	#set anim track
func attackfinish(timeout: bool):
	if not chargingattack: return
	chargingattack = false
	attacklevel = 1 if timeout else (3 - attacktiers.bsearch(attackcharge.time_left, true))
	print("Attack Level : ", attacklevel)
	attackcharge.stop()
#campfire-----------------------------------------------------------------------
func campsystem():
	if Input.is_action_just_pressed("Interact") and at_camp: resting = !resting
	elif at_camp == false: resting = false
	if Input.is_action_just_pressed("Debug"):
		print(resting)
#grimoire system----------------------------------------------------------------
func open_grimoire():
	if Input.is_action_just_pressed("Debug"):
		grimiore_open = !grimiore_open
		Grimoire.visible = grimiore_open
