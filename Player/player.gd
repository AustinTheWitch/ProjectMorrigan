extends CharacterBody2D

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
var speed: int = 220
var movement: bool = false
#Jump---------------------------------------------------------------------------
var force: int = -220
var jumped: bool = false
#Blink--------------------------------------------------------------------------
@onready var blinkcooldown: Timer = $Blink
var potency: int = 275
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
#Attack Charge Tiers: X = No Charge, Y = Half, Z = Full
var attackchargelevels: Vector3 = Vector3(3.0, 2.5, 1.0)
var chargeattackdamage: Vector3 = Vector3(2, 3, 6)
var currentattackcharge: float
var chargingattack: bool = false


func _ready():
	pass
func _process(_delta):
	selectsummon()
	playerattack()
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
const GODOT = preload("res://Familiars/Godot.tres")
const OTHER_GODOT = preload("res://Familiars/OtherGodot.tres")
func selectsummon():
	if Input.is_action_just_pressed("DebugEnemy"):
		summoning = true
		familiarincantation.start()
		familarname = GODOT
		#set Summoning anim track
	elif Input.is_action_just_pressed("DebugHealth"): 
		var check: bool
		summoning = true
		familiarincantation.start()
		familarname = OTHER_GODOT
		#set Summoning anim track
		FamiliarPage.familiarpage.visible = check
	if summoning == false: 
		familiarincantation.stop()
		#set Previous anim track
func summonfamiliar(familiar: Familiar):
	blinkcharges = familiar.blink_charge_bonus
	defense = familiar.defense_bonus
	familiarsprite.position = familiar.position
	familiarsprite.sprite_frames = familiar.anim_frames
	print(defense, " and ", blinkcharges)
func _familiarincanting():
	familiarincantation.stop()
	summoning = false
	summonfamiliar(familarname)
#attack system------------------------------------------------------------------
func playerattack():
	if Input.is_action_just_pressed("Attack"):
		attackcharge.start()
		chargingattack = true
		#set attack anim track
	if Input.is_action_just_released("Attack") and chargingattack == true:
		currentattackcharge = attackcharge.time_left
		attackcharge.stop()
		chargingattack = false
		attacklevel(currentattackcharge, damage)
func attacklevel(attacktier: float, attackdamage: int):
	if attacktier >= attackchargelevels.x:
		#No Charge Damage
		pass
	elif attacktier <= attackchargelevels.y and attacktier >= attackchargelevels.z:
		#Half Charge Damage
		pass
	elif attacktier <= attackchargelevels.z:
		#Full Charge Damage
		pass
	print(attackdamage)
func attacklevelreset():
	attackcharge.stop()
	chargingattack = false
	#set damage to base level
