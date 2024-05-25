extends Resource
class_name AttackInstance

# An easy way that I use to communicate attack damage universally, allows for the 
# modular addition of status effects and attack types. Would personnaly reccomend all 
# adopt this system, but can be freely removed if you delete the attack_instance 
# configuration in GunResource.gd

@export var attack_damage: float
