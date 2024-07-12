extends CharacterBody2D

#Refs---------------------------------------------------------------------------
@onready var player: AnimatedSprite2D = $AnimSprite
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var raycast: RayCast2D = $RayCast2D
@onready var blinkcooldown: Timer = $Blink
@onready var pov: Camera2D = $Camera2D
@onready var familiarsprite: AnimatedSprite2D = $FamiliarSprite
@onready var summon: Timer = $Summon
#Stats--------------------------------------------------------------------------
var health: int
var defense: int
#Movement-----------------------------------------------------------------------
var direction: float = 1
var speed: int = 220
var movement: bool = false
#Jump---------------------------------------------------------------------------
var force: int = -220
var jumped: bool = false
#Blink--------------------------------------------------------------------------
var potency: int = 275
var blinked: bool = false
var blinkcharges: int = 1
var currentcharge: int = 0
#Camera-------------------------------------------------------------------------
var bossroom: bool = false
#Familiar-----------------------------------------------------------------------
var familiarname: String
var summoning: bool = false

func _ready():
	familiarname = "godot"
func _process(_delta):
	selectsummon()
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
	elif Input.is_action_pressed("Left"):
		direction = -1
		velocity.x = direction * speed
		player.flip_h = true
		#movement anim track here
		movement = true
		summoning = false
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
	if Input.is_action_just_pressed("DebugEnemy") and summoning == false: 
		summoning = true
		summon.start()
	elif Input.is_action_just_pressed("DebugHealth"): 
		summoning = true
		summon.start()
	if summoning == false: summon.stop()
func summonfamiliar(familiar: Familiar):
	blinkcharges = familiar.blink_charge_bonus
	defense = familiar.defense_bonus
	familiarsprite.position = familiar.position
	familiarsprite.sprite_frames = familiar.anim_frames
	print(defense, " and ", blinkcharges)
