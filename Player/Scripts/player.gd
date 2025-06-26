extends character
class_name player
#timers
@onready var blink: Timer = $timers/blink
@onready var combo: Timer = $timers/combo
@onready var windup: Timer = $timers/windup
@onready var deflect: Timer = $timers/deflect
@onready var attack: Timer = $timers/attack
@onready var recovery: Timer = $timers/recovery
#blink stats
var blink_cooldown: float = 1.7
var blink_charges: int
var max_charges: int
#weapon
@export var weapon_loadout: Array[WEAPON]
var equipped_weapon: int = 0
var atk_weight: bool
var atk_number: int = 0
var atk_ready: bool
var atk_speed: float
#fall recovery
var recovered: bool

func _ready() -> void:
	signal_connections()
	player_stats()
	damage_taken.emit(current_health, max_health)
	equip_weapon()
func _physics_process(delta: float) -> void: pass
#set player stats
func player_stats() -> void:
	speed = 400
	current_health = 10
	max_health = 10
	blink_charges = 0
	max_charges = 1
	blink_cooldown = 1.7
	blink_distance = 500.0
	atk_speed = 2.5
	atk_ready = true
#blink functions
func blink_system()-> void:
	blink_charges += 1
	blink.start(blink_cooldown)
func _on_blink_timeout() -> void: blink_charges -= 1
#weapon loadout functions
func equip_weapon() -> void:
	if weapon_loadout.is_empty(): return
	var active_wpn = weapon_loadout[equipped_weapon]
	weapon.weapon_data(active_wpn)
#combat timers
func _on_combo_reset_timeout() -> void: atk_number = 0
func _on_attack_windup_timeout() -> void: atk_weight = true
func _on_deflect_timeout() -> void: deflecting = false
func _on_attack_timeout() -> void: atk_ready = true
func _on_recovery_timeout() -> void: recovered = true
