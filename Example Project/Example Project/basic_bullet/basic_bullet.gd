extends GunProjectile
class_name BasicBullet

@onready var base_sprite: AnimatedSprite2D = $BulletBase

var direction: Vector2
var starting_position: Vector2

func _ready() -> void:
	starting_position = global_position
	scale = Vector2(gun_resource.projectile_scale, gun_resource.projectile_scale)

func _physics_process(delta: float) -> void: 
	
	if global_position.distance_to(starting_position) > gun_resource.projectile_range:
		queue_free()
	
	if base_sprite.sprite_frames.animations.has("default"):
		base_sprite.play("default")
	
	
	direction = Vector2(gun_resource.projectile_speed, 0).rotated(rotation)
	
	velocity = direction * delta
	
	move_and_slide()
