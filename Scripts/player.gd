extends CharacterBody2D

#Refs-----------------------------------------------------------------------------------------------
var game: Node
var player: AnimatedSprite2D
var direction: float = 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#Stats----------------------------------------------------------------------------------------------
var health: int
var defense: int
#Movement-------------------------------------------------------------------------------------------
var speed: int = 220
var movement: bool = false
#Jump-----------------------------------------------------------------------------------------------
var force: int = -200
var jumped: bool = false
#Blink----------------------------------------------------------------------------------------------
var potency: int = 275
var blinked: bool = false
var blinkcooldown: Timer
var blinkcharges: int = 2
var currentcharge: int = 0

func _ready():
	game = get_node("/root/Gamemanager")
	player = $AnimSprite
	blinkcooldown = $Blink
func _process(_delta):
	pass
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	playerjump()
	setdirection()
	blink()
	move_and_slide()
#set player jumping---------------------------------------------------------------------------------
func playerjump():
	if Input.is_action_just_pressed("Up") and jumped == false:
		jumped = true
		position.y = global_position.y + force
		#jump anim track here
	elif is_on_floor():
		jumped = false
#set player direction-------------------------------------------------------------------------------`
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
#set player blink-----------------------------------------------------------------------------------
func blink():
	if Input.is_action_just_pressed("Blink") and blinked == false:
		currentcharge += 1
		if currentcharge >= blinkcharges: blinked = true
		if movement == false: position.x = global_position.x + (potency * direction) * -1
		else: position.x = global_position.x + (potency * direction)
		print(potency * direction)
		print(currentcharge)
		blinkcooldown.start()
func blinktime():
	blinked = false
	if currentcharge <= 0:
		blinkcooldown.stop()
	else: currentcharge -= 1
	print(currentcharge)

