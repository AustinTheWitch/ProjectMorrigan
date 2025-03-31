extends CharacterBody2D
class_name player_scene
#Refs---------------------------------------------------------------------------
@onready var player: AnimatedSprite2D = $AnimSprite
@onready var level: Node2D = self.get_parent()
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#Stats--------------------------------------------------------------------------
var maxhealth: int = 10
var health: int = 10
var defense: int = -2
var damage: int = 2
var spelldamage: int
#Movement-----------------------------------------------------------------------
var direction: float = 1
var speed: int = 330
var movement: bool = false
#Jump---------------------------------------------------------------------------
var force: int = 575
var jumped: bool = false
#Blink--------------------------------------------------------------------------
@onready var blink_cooldown: Timer = $Blink_Cooldown
@onready var blink_recharge: Timer = $Blink_Recharge
var potency: int = 3500
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
@onready var shoot_point: Node2D = $Shoot_Point
#Attack Charge Tiers: X = Half Charge Cutoff, Y = Full Charge Cutoff
var attacktiers: Array[float] = [1.00, 2.0]
var attacklevel: int
var chargingattack: bool = false
#Camp---------------------------------------------------------------------------
var conversation_played: bool
@export var current_camp: Camp
#Player UI=---------------------------------------------------------------------
@onready var player_ui: CanvasLayer = $player_ui
var healthbar = ProgressBar
func _ready():
	playerhealth()
	print(level)
func _process(_delta):
	attackinput()
	if Input.is_action_just_pressed("Interact"): campsystem()
	if is_instance_valid(current_camp): 
		player_ui.visible = !current_camp.camp_ui.visible
	else: player_ui.visible = true
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	playerjump()
	setdirection()
	blink()
	move_and_slide()
#set player jumping-------------------------------------------------------------
func playerjump():
	if Input.is_action_just_pressed("Up") and !jumped:
		jumped = true
		velocity.y = -1 * force
		#jump anim track here
	elif is_on_floor():
		jumped = false
		velocity.y = 0
#set player direction-----------------------------------------------------------
func setdirection():
	if Input.is_action_pressed("Right") and !blinked:
		direction = 1
		velocity.x = direction * speed
		player.flip_h = false
		#movement anim track here
		movement = true
	elif Input.is_action_pressed("Left") and !blinked:
		direction = -1
		velocity.x = direction * speed
		player.flip_h = true
		#movement anim track here
		movement = true
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		movement = false
		player.play("Idle")
#set player blink---------------------------------------------------------------
func blink():
	if Input.is_action_just_pressed("Blink") and currentcharge != blinkcharges:
		currentcharge += 1
		blinked = true
		if currentcharge >= blinkcharges: blink_recharge.start()
		var blink_direction = direction if movement or jumped else -direction
		velocity.x = blink_direction * potency
		blink_cooldown.start(0.3)
		await blink_cooldown.timeout
		blinked = false
		blink_cooldown.stop()
func blinktime():
	if currentcharge <= 0:
		blink_recharge.stop()
	else: currentcharge -= 1
	print(currentcharge)
#set camera---------------------------------------------------------------------
func playercam():
	pass
func playerhealth():
	healthbar = player_ui.find_child("Health_Bar")
	healthbar.value = health
	healthbar.max_value = maxhealth
	print(healthbar.max_value)
#attack system------------------------------------------------------------------
func attackinput():
	if Input.is_action_just_pressed("Attack"): attackstart()
	if Input.is_action_just_released("Attack") or movement: attackfinish(false)
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
	#var spell = attackspell.instantiate()
	#shoot_point.position *= direction
	#spell.spawn(direction, shoot_point.global_position)
	#level.add_child(spell)
func _attacktimeout() -> void:
	attackfinish(true)
#camp/bonfire----------------------------------------------------------------++---
func campsystem():
	if is_instance_valid(current_camp):
		current_camp.campui()
