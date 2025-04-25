extends Resource
class_name PROJECTILE

@export var projectile_id: String
@export var projectile_path: String
@export var projectile_frames: SpriteFrames
@export var projectile_force: float
@export var projectile_falloff: float
@export var projectile_damage: Dictionary[String, float]
@export var sprite_frames: SpriteFrames
@export var ward_check: bool
