extends CharacterBody2D
class_name character

#nodes
@export var sprite: Node2D
@export var weapon: weapon_base
@export var animation_player: AnimationPlayer
@export var ui: base_ui
#signals
signal damage_taken
#stats
var speed: float
var current_health: int
var max_health: int
#gravity
const GRAVITY: float = 980.0
func gravity(delta: float) -> void: if not is_on_floor(): velocity.y += GRAVITY * delta
#ward
var ward_up: bool
var perfect_ward: bool
#blink
@export var blink_timer: Timer
var blink_distance: float = 150.0
var blink_cooldown: float = 1.7
var blink_charges: int = 0
var max_charges: int = 1
#weapon
@export var weapon_loadout: Array[WEAPON]
var equipped_weapon: int = 0
var atk_weight: bool
var atk_number: int
#combat
@export var attack_windup: Timer
@export var combo_reset: Timer

func signal_connections() -> void: 
	damage_taken.connect(ui.update_healthbar)
func equip_weapon() -> void:
	if weapon_loadout.is_empty(): return
	var active_wpn = weapon_loadout[equipped_weapon]
	weapon.weapon_data(active_wpn)
