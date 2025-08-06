extends character
class_name knight

@export var raycast_2d: RayCast2D #line of sight detection
var player_detected: bool
@export var player_target: player

func _ready() -> void:
	#healthbar update
	update_health.connect(health_bar.update_healthbar)
	#stats
	speed = 300
	current_health = 20
	max_health = 20
	#connections and signals
	update_health.emit(current_health, max_health)

func _process(delta: float) -> void: 
	if raycast_2d.is_colliding():
		var colliding_object = raycast_2d.get_collider()
		if colliding_object is player: player_detected = true
		else: player_detected = false
func _physics_process(delta: float) -> void: pass
