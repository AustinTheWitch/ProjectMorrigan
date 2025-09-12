extends character
class_name player
#timers
@onready var blink: Timer = $timers/blink
@onready var combo: Timer = $timers/combo
@onready var recovery: Timer = $timers/recovery
#blink stats
var blink_cooldown: float = 1.7
var blink_charges: int
var max_charges: int
#weapon
var equipped_weapon: int = 0
var atk_speed: float
#fall recovery
var recovered: bool
#resting
var resting: bool = false
#keychain check
var keychain: Array [String]
#interaction input possible
static var interact: interactable


func _ready() -> void:
	#signal connects
	update_health.connect(health_bar.update_healthbar)
	update_health.emit(current_health, max_health)
	#stats
	speed = 600
	current_health = 20
	max_health = 20
	blink_charges = 0
	max_charges = 1
	blink_cooldown = 1.7
	blink_distance = 800.0
	atk_speed = 1.1
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Debug"): pass
func _on_blink_timeout() -> void: blink_charges -= 1
func _on_combo_reset_timeout() -> void: atk_number = 0
func _on_recovery_timeout() -> void: recovered = true
