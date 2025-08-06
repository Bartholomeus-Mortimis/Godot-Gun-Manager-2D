extends Node2D

@onready var character_body_2d: CharacterBody2D = $CharacterBody2D
@onready var gun_component: Node2D = $CharacterBody2D/GunComponent

func _process(_delta):
	gun_component.muzzle_position = character_body_2d.position
	character_body_2d.look_at(get_global_mouse_position())
	if Input.is_action_pressed("shoot"):
		gun_component.shoot_gun()
	if Input.is_action_just_pressed("reload"):
		gun_component.reload_gun()
	character_body_2d.move_and_slide()
