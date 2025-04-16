extends character

#movement
var direction: float
var blink_distance: float = 150.0
const GRAVITY: float = 980.0
#blink
@onready var blink: Timer = $Blink
var blink_cooldown: float = 1.0
var current_blink: int = 0
var max_blink: int = 1
#ward
@onready var ward: Timer = $Ward
var ward_up: bool
var perfect_ward: bool

func _ready() -> void:
	speed = 170
	health = 10
func _physics_process(delta: float) -> void:
	movement_system(delta)
	move_and_slide()
	warding()
	if Input.is_action_just_pressed("ward"): perfect_warding()
	if Input.is_action_just_pressed("Debug"): pass
func movement_system(delta: float)-> void:
	#ward prevents movement? if so, place before this
	if ward_up: 
		velocity.x = 0.0
		return
	#setting direction
	if Input.is_action_just_pressed("ui_right"):
		direction = 1
		animated_sprite_2d.flip_h = false
	elif Input.is_action_just_pressed("ui_left"):
		direction = -1
		animated_sprite_2d.flip_h = true
	#setting velocity
	velocity.x = Input.get_axis("ui_left", "ui_right")
	velocity = velocity.normalized() * speed
	if not is_on_floor(): velocity.y += GRAVITY * delta
	#setting blink
	if Input.is_action_just_pressed("blink") and current_blink < max_blink:
		if velocity.x == 0.0: velocity.x = blink_distance * (-direction * blink_distance)
		else: velocity.x = blink_distance * velocity.x
		current_blink += 1
		blink.start(blink_cooldown)
func _on_blink_timeout() -> void:
	current_blink -= 1
	blink.stop()
func warding() -> void: 
	ward_up = Input.is_action_pressed("ward")
func perfect_warding() -> void: 
	perfect_ward = true
	ward.start(0.5)
func _on_ward_timeout() -> void:
	perfect_ward = false
