@tool
extends Resource
class_name CustomResourceBehaviour

var overide_base_behaviour: Dictionary = {
	"custom_shoot": false,
	"custom_shoot_failed": false,
	"custom_reload_begin": false,
	"custom_reload_end": false,
	"custom_reload_failed": false,
	"custom_destroy_gun": false,
	"custom_load_new_gun": false,
	"custom_ready": false,
	"custom_process": false
}

# If you want to further customize the functions of a specific gun resource, the functions 
# below serve as a way to run custom code upon certain events. By default, the custom
# functions will run alongside the default ones, but if you want one or several custom
# functions to replace the default one completely, set them to true in the
# overide_base_behaviour 


func custom_shoot(_gun_resource: GunResource, _gun_host: Node2D):
	
	# Calls on shoot
	
	pass

func custom_shoot_failed(_gun_resource: GunResource, _gun_host: Node2D):
	
	# Calls when shooting lacks ammunition
	
	pass

func custom_reload_begin(_gun_resource: GunResource, _gun_host: Node2D):
	
	# Calls at the beginning of a reload
	
	pass

func custom_reload_end(_gun_resource: GunResource, _gun_host: Node2D):
	
	# Calls at the end of a reload
	
	pass

func custom_reload_failed(_gun_resource: GunResource, _gun_host: Node2D):
	
	# Calls when reload lacks ammunition
	
	pass

func custom_destroy_gun(_gun_resource: GunResource, _gun_host: Node2D):
	
	# Calls before destroying an old weapon
	
	pass

func custom_load_new_gun(_gun_resource: GunResource, _gun_host: Node2D, _new_gun: GunResource):
	
	# Calls after loading a new weapon 
	
	pass

func custom_ready(_gun_resource: GunResource, _gun_host: Node2D):
	
	# Calls on ready
	
	pass

func custom_process(_delta: float):
	
	# Calls every frame
	
	pass
