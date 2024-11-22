extends character_base

#movement
var moving: bool = false
#jump
var jumped: bool = false
#blink
@onready var blink_recharge: Timer = $"Blink Recharge"
var blinked: bool = false
var blink_charge: int = 0
var blink_limit: int = 1
var blink_strength: int
#base attacks
@onready var incantation: Timer = $Incantation
var incanting: bool
var incant_stages: Array [float]
var attack_combo: int
var combo_damage: Array[Vector3]
#spells
var spell_damage: int
var spellcasting: bool

func _ready() -> void:
	speed = 335
	force = 575
	blink_charge = 0
	blink_limit = 1
	blink_strength = 5000
	incanting = false
	incant_stages = [1.0, 3.0]
	combo_damage = [Vector3(2, 3, 5), Vector3(3, 4, 5), Vector3(2, 4, 8)]
	
func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	player_movement()
	move_and_slide()
	player_combat()

#movement
func player_movement():
	#basic movement
	if Input.is_action_pressed("Left"): 
		direction.x = -1
		moving = true
	elif Input.is_action_pressed("Right"):
		direction.x = 1
		moving = true
	else: moving = false
	if moving: 
		velocity.x = direction.x * speed
	else: velocity.x = 0
	#jump movement
	if Input.is_action_just_pressed("Jump") and !jumped: 
		jumped = true
		velocity.y = force * -1
	elif is_on_floor(): 
		jumped = false
		velocity.y = 0
	#blink
	if Input.is_action_just_pressed("Blink") and !blinked:
		blink_charge += 1
		if blink_charge >= blink_limit: 
			blinked = true
			blink_recharge.start()
		var blink_direction = direction.x if jumped or moving else -direction.x
		velocity.x = blink_direction * blink_strength
func _on_blink_recharge_timeout() -> void:
	blink_charge -= 1
	if blink_charge <= 0: 
		blinked = false
		print("blink ready")
		blink_recharge.stop()

func player_combat() -> void:
	if Input.is_action_just_pressed("Attack"): attack_start()
	if Input.is_action_just_released("Attack") or moving: attack_finish(false, attack_combo)
	if attack_combo > 2 or moving: attack_combo = 0

func attack_start() -> void:
	incanting = true
	incantation.start()
	if attack_combo == 0: print("first")
	elif attack_combo == 1: print("second")
	elif attack_combo >= 2: print("final")
func attack_finish(timedout: bool, combo: int) -> int:
	if not incanting: return 0
	incanting = false
	incantation.stop()
	attack_combo += 1
	if incantation.time_left <= incant_stages[0]: 
		damage = combo_damage[combo].x
	elif incantation.time_left > incant_stages[0] and incantation.time_left < incant_stages[1]:
		damage = combo_damage[combo].y
	elif incantation.time_left > incant_stages[1] or timedout:
		damage = combo_damage[combo].z
	print(damage)
	return damage

func _on_incantation_timeout() -> void:
	attack_finish(true, attack_combo)
