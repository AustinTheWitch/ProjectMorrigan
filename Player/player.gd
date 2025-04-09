extends character

#movement
var direction: float
var blink_distance: float = 150.0
#blink
@onready var blink: Timer = $Blink
var blink_cooldown: float = 1.0
var current_blink: int = 0
var max_blink: int = 1
#seperator comment

func _ready() -> void:
	speed = 170
func _physics_process(delta: float) -> void:
	movement_system()
	move_and_slide()
func movement_system()-> void:
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
	#setting blink
	if Input.is_action_just_pressed("Debug") and current_blink < max_blink:
		if velocity.x == 0.0: velocity.x = blink_distance * (-direction * blink_distance)
		else: velocity.x = blink_distance * velocity.x
		current_blink += 1
		blink.start(blink_cooldown)
func _on_blink_timeout() -> void:
	current_blink -= 1
	blink.stop()
