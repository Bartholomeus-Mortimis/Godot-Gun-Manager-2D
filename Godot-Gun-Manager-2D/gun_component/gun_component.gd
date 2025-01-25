extends Node2D
class_name GunComponent

@export_category("General Settings")
@export var gun_resource: GunResource
@export var gun_host: Node2D # The node that uses the component (Ex: The Player Character)
@export var muzzle_position: Vector2
@export var custom_component_behavior: CustomComponentBehavior = CustomComponentBehavior.new() # Insert a CustomComponentBehavior here, even if it is blank. Otherwise, it will cause a crash.

@export_category("Active Settings") # These are meant to be controlled by others nodes in the scene (Like the main game script)
@export var can_shoot: bool = true
@export var can_reload: bool = true

@export_category("Ammunition Settings")
@export var infinite_ammo_stored: bool = true # If true, reloading will disregard stored ammo.
@export var ammo_in_clip: int
@export var stored_ammo_types: Dictionary = {
	"universal": 100
	# Add the ammo types you wish to use, all values must be intergers
}


var is_shooting: bool = false # If the gun is currently shooting.
var is_reloading: bool = false # If the gun is currently reloading.
var awaiting_firerate_cooldown: bool = false # If the firerate cooldown timer is still active.


func shoot_gun():
	
	if gun_resource and gun_host and !is_shooting and !is_reloading and !awaiting_firerate_cooldown: # Check if shooting is possible
		if !gun_resource.custom_behaviour_script.overide_base_behaviour["custom_shoot"]:
			
			if ammo_in_clip > 0 or !gun_resource.use_ammo: # Check ammunition
				
				if gun_resource.use_ammo: # Remove 1 Ammo from clip
					ammo_in_clip -= 1
				
				is_shooting = true
				
				
				for b in gun_resource.burst_amount: # Burst Fire
					
					var spread_angle_extreme: float = gun_resource.spread_range / 50 / 2 # The furthest an angle can spread in each direction. The 50 is to fit with some bug in the engine.
					
					for p in gun_resource.projectile_quantity:  # Spawn projectiles and applies spread
						if !gun_resource.consistent_spread:
							spawn_projectile(gun_host, muzzle_position, global_rotation + randf_range(-spread_angle_extreme, spread_angle_extreme)) # Rotates the projectile randomly
						elif gun_resource.consistent_spread:
							
							var adjusted_quantity: int = gun_resource.projectile_quantity - 1 # Quantity adjusted to fit calculations
							var projectile_deviation: float = gun_resource.spread_range / adjusted_quantity / 50
							
							if gun_resource.projectile_quantity > 1:
								spawn_projectile(self, muzzle_position, global_rotation + -spread_angle_extreme + projectile_deviation * p) # Rotate the projectile in a pattern
							else:
								spawn_projectile(self, muzzle_position, global_rotation) # Does not apply rotation if only 1 projectile
						
						if gun_host is CharacterBody2D:
							gun_host.velocity += Vector2(-gun_resource.character_recoil, 0).rotated(gun_host.rotation)
					
					
					gun_resource.custom_behaviour_script.custom_shoot(gun_resource, gun_host)
					custom_component_behavior.custom_shoot(self, gun_host)
					
					if b < gun_resource.burst_amount: # Do not cause delay on last burst
						await get_tree().create_timer(gun_resource.burst_interval).timeout
				
				if is_shooting:
					is_shooting = false
				
				awaiting_firerate_cooldown = true
				await get_tree().create_timer(gun_resource.firerate).timeout
				if awaiting_firerate_cooldown:
					awaiting_firerate_cooldown = false
				
			else: # Not enough ammunition to shoot
				gun_resource.custom_behaviour_script.custom_shoot_failed(gun_resource, gun_host)
				custom_component_behavior.custom_shoot_failed(self, gun_host)
		else:
			gun_resource.custom_behaviour_script.custom_shoot(gun_resource, gun_host)
			custom_component_behavior.custom_shoot(self, gun_host)

func reload_gun():
	if gun_resource and gun_host and gun_resource.use_ammo and can_reload and !is_shooting and !is_reloading: # Checks if reload is currently allowed
		if !gun_resource.custom_behaviour_script.overide_base_behaviour["custom_reload_begin"]:
			var reload_info: Dictionary = get_reload_info(ammo_in_clip, gun_resource.clip_size, stored_ammo_types[gun_resource.ammo_type])
			
			if reload_info["can_reload"]:
				awaiting_firerate_cooldown = false
				is_reloading = true
				gun_resource.custom_behaviour_script.custom_reload_begin(gun_resource, gun_host)
				custom_component_behavior.custom_reload_begin(self, gun_host)
				await get_tree().create_timer(gun_resource.reload_time).timeout # Starts reload timer
				reload_timer_timeout(reload_info) # Ends reload
			else:
				gun_resource.custom_behaviour_script.custom_reload_failed(gun_resource, gun_host)
				custom_component_behavior.custom_reload_failed(self, gun_host)
		else:
			gun_resource.custom_behaviour_script.custom_reload_begin(gun_resource, gun_host)
			custom_component_behavior.custom_reload_begin(self, gun_host)


func reload_timer_timeout(reload_info: Dictionary) -> void:
	if is_reloading: # Finish the reload
		if !gun_resource.custom_behaviour_script.overide_base_behaviour["custom_reload_end"]:
			
			ammo_in_clip = reload_info["ammo_in_clip"]
			stored_ammo_types[gun_resource.ammo_type] = reload_info["ammo_stocked"]
			
			gun_resource.custom_behaviour_script.custom_reload_end(gun_resource, gun_host)
			custom_component_behavior.custom_reload_end(self, gun_host)
			
			is_reloading = false
		else:
			gun_resource.custom_behaviour_script.custom_reload_end(gun_resource, gun_host)
			custom_component_behavior.custom_reload_end(self, gun_host)

func load_gun(new_gun: GunResource):
	if !gun_resource.custom_behaviour_script.overide_base_behaviour["custom_load_new_gun"]:
		
		gun_resource.custom_behaviour_script.custom_destroy_gun(gun_resource, gun_host)
		custom_component_behavior.custom_destroy_gun(self, gun_host)
		ammo_in_clip = gun_resource.clip_size
		
		is_shooting = false
		is_reloading = false
		
		gun_resource.custom_behaviour_script.custom_load_new_gun(gun_resource, gun_host, new_gun)
		custom_component_behavior.custom_load_new_gun(self, gun_host, new_gun)
	else:
		gun_resource.custom_behaviour_script.custom_load_new_gun(gun_resource, gun_host, new_gun)
		custom_component_behavior.custom_load_new_gun(self, gun_host, new_gun)


# Additional Functions

func spawn_projectile(origin: Node2D, projectile_position: Vector2, projectile_rotation: float):
	
	if gun_resource.projectile_scene:
		
		var projectile_instance = gun_resource.projectile_scene.instantiate()
		
		if projectile_instance is GunProjectile: # Attaches the GunResource to the projectile, allowing it to know how to behave.
			projectile_instance.gun_resource = gun_resource
		
		projectile_instance.global_position = projectile_position
		projectile_instance.rotation = projectile_rotation
		
		origin.get_tree().root.add_child(projectile_instance)
		

func get_reload_info(ammo_left_in_clip: int, max_ammo_in_clip: int, ammo_stocked: int): # Calls to get specifications of weapon reload
	
	var ammo_pool = ammo_stocked + ammo_left_in_clip # Combines all ammo together.
	
	if infinite_ammo_stored: # Full reload
		return {"can_reload": true, "ammo_in_clip": max_ammo_in_clip, "ammo_stocked": ammo_stocked}
		
	elif ammo_stocked <= 0 or ammo_in_clip >= max_ammo_in_clip: # If no more ammo left OR clip already full (So no reload)
		return {"can_reload": false, "ammo_in_clip": ammo_left_in_clip, "ammo_stocked": ammo_stocked}
		
	elif ammo_pool >= max_ammo_in_clip: # Full reload
		return {"can_reload": true, "ammo_in_clip": max_ammo_in_clip, "ammo_stocked": ammo_pool - max_ammo_in_clip}
		
	elif ammo_pool >= 1 and ammo_pool < max_ammo_in_clip: # Partial reload
		return {"can_reload": true, "ammo_in_clip": ammo_pool, "ammo_stocked": 0}
		
	else: # Error or unexpected situation, keep as is.
		return {"can_reload": false, "ammo_in_clip": ammo_left_in_clip, "ammo_stocked": ammo_stocked}

func _ready():
	if !gun_resource.custom_behaviour_script.overide_base_behaviour["custom_load_new_gun"]:
		load_gun(gun_resource)
		gun_resource.custom_behaviour_script.custom_load_new_gun(gun_resource, gun_host, gun_resource)
		custom_component_behavior.custom_load_new_gun(self, gun_host, gun_resource)
	else:
		gun_resource.custom_behaviour_script.custom_load_new_gun(gun_resource, gun_host, gun_resource)
		custom_component_behavior.custom_load_new_gun(self, gun_host, gun_resource)
		
