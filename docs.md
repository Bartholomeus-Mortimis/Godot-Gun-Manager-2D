# Documentation

## Implementation
To add to your game, simply drag the folder into your project and repair any dependancy issues.

<br>

## Usage

### The Main Components

#### GunResource
> A list of stats and characteristics that make up an individual gun. Read by GunComponent.

#### GunComponent
> The node that allows the gun to work. Facilitates the shooting + reloading logic, spawning projectiles and ammo management. Uses a GunResource as a guidebook on how said actions are to be done. Can be extended to run custom code when these actions are performed.

#### CustomResourceBehaviour
> Resource that is attahced to a GunResource, allows for custom code to be executed when a GunComponent loaded with said GunResource performs certain actions (reloading, shooting, loading new gun, etc.). Theses custom function can be set to override the GunComponent's code, or be called alongside it.

<br>

## GunResource Properties

### General

#### gun_name (String) 
> Used for organisation. Can be left blank.

#### custom_resource_behaviour_script (CustomResourceBehavior)
> References a CustomResourceBehaviour to allow for further customization.

> [!WARNING]
> custom_resource_behaviour_script <b>cannot</b> be left blank! Otherwise, a crash will occur. Add a CustomResourceBehaviour, even if no code is written to it. 

<br>

### Shooting

#### attack_instance (AttackInstance)
> References an AttackInstance. Will cause crash if referenced while blank.

#### firerate (float)
> The amount of time the gun must wait before it can shoot again. Lower Value = Faster Shooting.

#### character_recoil (float)
> The amount of recoil applied to the gun's host when fired. Host must be CharacterBody2D for recoil to apply.

<br>

### Ammunition

#### clip_size (int)
> Maximum amount of shots allowed before having to reload gun.

#### reload_time (float)
> Time it takes to reload gun.

#### ammo_type (String)
> Type of ammo consumed taken from GunComponent on reload. Set to 'default' by default.

#### use_ammo (bool)
> If set to false, the gun's clip size will be set to infinite, and reloading will be disabled. False by default.

<br>

### Projectile

> [!NOTE]
>  It is recommended to have the scene for projectile_scene be extended from the GunProjectile class (inherits CharacterBody2D). Otherwise, the projectile settings will be unused.

#### projectile_scene (PackedScene)
> The scene that will be instanced when creating a projectile. Any scene will work, but a GunProjectile is recommended.

#### projectile_scale (float)
> Multiplies scale of projectiles. Default is 1.0

#### projectile_speed (float)
> Speed that projectiles will move at.

#### projecile_range (float)
> Maximum distance away from spawn position a projectiles can travel before automatically being deleted.

<br>

### Advanced Settings

### Projectile Spread

#### consistent_spread (bool)
> If true, projectiles will keep equal distance to eachother when deviating. If false, they will just each have a random angle of deviation.

#### spread_range (float)
> The arc of the gun's spread.

#### projectile_quantity (int)
> The amount of projectiles spawned per shot. This will not change the ammount of ammo consumed per shot.

<br>

### Burst

#### burst_amount (int)
> The amount of burst per shot. This will not change the ammount of ammo consumed.

#### burst_interval (float)
> Time between each burst.


<br>


## GunComponent

### Properties

#### gun_resource (GunResource)
> The attached gun to the GunComponent. This is treated as the currently equipped gun.

#### gun_host (Node2D)
> Whichever node is using the GunComponent (Player, Enemy, etc.)

#### muzzle_position (Vector2)
> The position at which projectiles will spawn.

#### muzzle_host_node (Node2D)
> The node that the gun will use to determine the orientation of the shot projectile. Used the global_rotation of the given node.

#### custom_component_behavior (CustomComponentBehaviour)
> References a CustomComponentBehaviour to allow for further customization. Will cause a crash if left blank.

#### can_shoot (bool)
> Disables the gun from firing. Meant to be controlled by other nodes.

#### can_reload (bool)
> Disables the gun from reloading. Meant to be controlled by other nodes.

#### infinite_ammo_stored (bool)
> If true, the gun will always fully reload no matter the ammo stored. True by default.

#### ammo_in_clip (int)
> Amount of ammo left in the gun's clip.

#### stored_ammo_types (Dictonary)
> List of ammo types stored. All values should be intergers. (Etc: 'default': 100).

<br>

### Methods

#### shoot_gun()
> Fires the gun. Will run all checks to ensure shooting is possible within the method (No checks are needed).

#### reload_gun()
> Reloads the gun. Will run all checks to ensure reloading is possible within the method (No checks are needed).

#### load_gun(new_gun: GunResource)
> Adds new_gun / Swaps the existing gun with new_gun.

<br>
