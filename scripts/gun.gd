extends player_weapon
class_name gun

@export var gun_texture : Texture2D
@export var bullet_prefab : PackedScene = preload("res://ModularBulletStuff/mod_bullet.tscn")
@export var max_ammo : int = 100
@export var clip_size : int = 6
@export var auto_fire_delay : float = 0.8
@export var reload_time : float = 1.5
var current_ammo = clip_size 


var shot_type : Shot_Type = single_shot.new()
var shot_direction : Shot_Direction = ForwardShot.new()

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
	# Might want to change the structure of these if statements as they are not very readable
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
	elif (Input.is_action_pressed("left_click") and current_ammo == 0):
		if (reloadable()):
			shoot.emit(0, max_ammo)
			var timer : Reload_Timer = Reload_Timer.new(get_parent(), reload_time)
			timer.end_of_reload.connect(reload)
			add_child(timer)

		
	if (Input.is_action_just_pressed("reload") and reloadable()):
		#Kind of hacky, should attempt to fix that
		shoot.emit(0, max_ammo)
		var timer : Reload_Timer = Reload_Timer.new(get_parent(), reload_time)
		timer.end_of_reload.connect(reload)
		add_child(timer)
	

func on_click() -> void:
	var direction = (get_global_mouse_position() - global_position).normalized()
	for dir in shot_direction.calculate_directions(direction):
		shot_type.create(bullet_prefab, global_position, dir, rotation, get_tree()) 

func reloadable() -> bool:
	return max_ammo != 0 and get_child_count() == 0 and current_ammo != clip_size

func reload():
	max_ammo -= (clip_size - current_ammo)
	if (max_ammo < 0):
		current_ammo = clip_size + max_ammo
		max_ammo = 0
	else:
		current_ammo = clip_size
	shoot.emit(current_ammo, max_ammo)
