extends Resource
class_name GunResource

@export_group("General")
@export var gun_name: String
@export var custom_behaviour_script: CustomResourceBehavior # Insert a CustomResourceBehavior here, even if it is blank. Otherwise, it will cause a crash.

@export_group("Shooting")
@export var attack_instance: AttackInstance
@export var firerate: float = 1
@export var character_recoil: float # only applies if host is CharacterBody2D

@export_group("Ammunition")
@export var clip_size: int
@export var reload_time: int
@export var ammo_type: String
@export var use_ammo: bool = false # If false, the gun will have infinite clip size.

@export_group("Projectile")
# It is recommended to have the scene for projectile_scene be extended from
# the GunProjectile class (inherits CharacterBody2D). Otherwise, the projectile settings will be unused.
@export var projectile_scene: PackedScene
@export var projectile_scale: float = 1.0
@export var projectile_speed: float = 75000.0
@export var projectile_range: float = 100000.0

@export_group("Advanced Settings")

@export_subgroup("Projectile Spread")
@export var consistent_spread: bool = false # If true, projectiles will keep equal relative deviation when fired.
@export var spread_range: float = 0.0 # The maximum deviation of projectiles
@export var projectile_quantity: int = 1

@export_subgroup("Burst")
@export var burst_amount: int = 1
@export var burst_interval: float = 0.0
