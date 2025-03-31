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
@onready var spell_origin: Node2D = $"Spell Origin"
@onready var incantation: Timer = $Incantation
var incanting: bool
var incant_stages: Array [float]
var attack_combo: int
var combo_damage: Array[Vector3]
var incant_time: float
var spell: PackedScene
#world
var level: Node2D

func _ready() -> void:
	speed = 335
	force = 575
	blink_charge = 0
	blink_limit = 1
	blink_strength = 5000
	incanting = false
	incant_stages = [2.0, 4.0]
	combo_damage = [Vector3(2, 3, 5), Vector3(3, 4, 5), Vector3(2, 4, 8)]
	level = get_parent()

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
	if incanting: rotation += incant_time * get_process_delta_time()

func attack_start() -> void:
	incanting = true
	incantation.start()
	spell = preload("res://Spells/impact_spell.tscn")
	if attack_combo == 0: incant_time = 1.0
	elif attack_combo == 1:incant_time = -1.0
	elif attack_combo >= 2: incant_time = 1.0
func attack_finish(timedout: bool, combo: int) -> void:
	if not incanting: return
	var incanting_stop: float = incantation.time_left
	rotation = 0
	incanting = false
	incantation.stop()
	attack_combo += 1
	if incanting_stop <= incant_stages[0]:
		damage = combo_damage[combo].z
		print("full")
	elif incanting_stop > incant_stages[0] and incanting_stop < incant_stages[1]:
		damage = combo_damage[combo].y
		print("mid")
	elif incanting_stop > incant_stages[1] or timedout:
		damage = combo_damage[combo].x
		print("light")
	var spell_casted = spell.instantiate()
	spell_casted.spawn(direction.x, spell_origin.global_position)
	level.add_child(spell_casted)
func _on_incantation_timeout() -> void:
	attack_finish(true, attack_combo)
