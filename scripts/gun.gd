extends player_weapon
class_name gun

@export var gun_texture : Texture2D
@export var bullet_prefab : PackedScene = preload("res://scenes/bullet.tscn")
@export var max_ammo : int = 100
@export var clip_size : int = 6
@export var auto_fire_delay : float = 0.8
var current_ammo = clip_size 
signal shoot
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (gun_texture):
		self.texture = gun_texture
		position_weapon(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_to_mouse(self)
	flip_weapon(self)
	#Add auto fire function that be acheived by holding down left click
	if (Input.is_action_just_pressed("left_click") and current_ammo > 0):
		current_ammo -= 1
		shoot.emit(current_ammo, max_ammo)
		on_click()
	elif (Input.is_action_pressed("left_click") and current_ammo > 0):
		auto_fire_delay -= delta
		if (auto_fire_delay < 0):
			current_ammo -= 1
			shoot.emit(current_ammo, max_ammo)
			on_click()
			
			auto_fire_delay = 0.8
		
	if (Input.is_action_just_pressed("reload") and max_ammo != 0):
		
		max_ammo -= clip_size
		if (max_ammo < 0):
			current_ammo = clip_size + max_ammo
			max_ammo = 0
		else:
			current_ammo = clip_size
		shoot.emit(current_ammo, max_ammo)
	

func on_click() -> void:
	var bullet_ist = bullet_prefab.instantiate()
	bullet_ist.direction = get_global_mouse_position() - global_position
	bullet_ist.direction = bullet_ist.direction.normalized()
	
	bullet_ist.rotation = rotation
	bullet_ist.global_position = global_position
	
	get_tree().root.add_child(bullet_ist)
