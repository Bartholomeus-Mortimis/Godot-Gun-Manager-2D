@tool
extends Resource
class_name CustomComponentBehavior

# If you want to further customize the functions of the gun component, the functions 
# below serve as a way to run custom code upon certain events.

func custom_shoot(_gun_component: GunComponent, _gun_host: Node2D):
	
	# Calls on shoot
	
	pass

func custom_shoot_failed(_gun_component: GunComponent, _gun_host: Node2D):
	
	# Calls when shooting lacks ammunition
	
	pass

func custom_reload_begin(_gun_component: GunComponent, _gun_host: Node2D):
	
	# Calls at the beginning of a reload
	
	pass

func custom_reload_end(_gun_component: GunComponent, _gun_host: Node2D):
	
	# Calls at the end of a reload
	
	pass

func custom_reload_failed(_gun_component: GunComponent, _gun_host: Node2D):
	
	# Calls when reload lacks ammunition
	
	pass

func custom_destroy_gun(_gun_component: GunComponent, _gun_host: Node2D):
	
	# Calls before destroying an old weapon
	
	pass

func custom_load_new_gun(_gun_component: GunComponent, _gun_host: Node2D, _new_gun: GunResource):
	
	# Calls after loading a new weapon 
	
	pass

func custom_ready(_gun_component: GunComponent, _gun_host: Node2D):
	
	# Calls on ready
	
	pass

func custom_process(_delta: float):
	
	# Calls every frame
	
	pass
