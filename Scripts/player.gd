extends CharacterBody2D

#Refs---------------------------------------------------------------------------
var game: Node
var player: AnimatedSprite2D
var direction: float = 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var raycast: RayCast2D
#Stats--------------------------------------------------------------------------
var health: int
var defense: int
#Movement-----------------------------------------------------------------------
var speed: int = 220
var movement: bool = false
#Jump---------------------------------------------------------------------------
var force: int = -220
var jumped: bool = false
#Blink--------------------------------------------------------------------------
var potency: int = 275
var blinked: bool = false
var blinkcooldown: Timer
var blinkcharges: int = 1
var currentcharge: int = 0
#Camera-------------------------------------------------------------------------
var pov: Camera2D
var bossroom: bool = false
#Familiar-----------------------------------------------------------------------
var familiarname: String
var familiarsprite: AnimatedSprite2D

func _ready():
	game = get_node("/root/Gamemanager")
	player = $AnimSprite
	blinkcooldown = $Blink
	raycast = $RayCast2D
	pov = $Camera2D
	familiarname = "godot"
	familiarsprite = $FamiliarSprite
	familiarsprite.position = Vector2(0, 0)
	print(familiarsprite.position)
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
	elif Input.is_action_pressed("Left"):
		direction = -1
		velocity.x = direction * speed
		player.flip_h = true
		#movement anim track here
		movement = true
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
func selectsummon():
	if Input.is_action_just_pressed("DebugEnemy"):
		familiarname = "godot"
		summoning()
	elif Input.is_action_just_pressed("DebugHealth"):
		familiarname = "othergodot"
		summoning()
func summoning():
	print("Here?")
	game.selectedfam(familiarname)
	familiar()
func familiar():
	blinkcharges = game.blinkcharges
	defense = game.newdefense
	familiarsprite.position = game.familiarpos
	familiarsprite.sprite_frames = game.familiarsanim
	print(defense, " and ", blinkcharges)
