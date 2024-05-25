extends Node2D

func _process(_delta):
	$CharacterBody2D/GunComponent.muzzle_position = $CharacterBody2D.position
	$CharacterBody2D.look_at(get_global_mouse_position())
	if Input.is_action_pressed("shoot"):
		$CharacterBody2D/GunComponent.shoot_gun()
	if Input.is_action_just_pressed("reload"):
		$CharacterBody2D/GunComponent.reload_gun()
	$CharacterBody2D.move_and_slide()
