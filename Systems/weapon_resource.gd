extends Resource
class_name WEAPON

@export var wpn_id: String #weapon name/type
@export var wpn_spriteframes: SpriteFrames #weapon sprites and anims
@export var damage_dict: Dictionary[String, float] #weapon attack string: damage float
@export var wpn_reach: float
@export var wpn_speed: float #attack cooldown timer
@export var projectile_resource: PROJECTILE #projectile that is pre-loaded
