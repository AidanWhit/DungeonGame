extends player_weapon
class_name gun

@export var gun_texture : Texture2D
@export var bullet_prefab : PackedScene = preload("res://scenes/bullet.tscn")

@onready var firepoint : Marker2D = $"FirePoint"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (gun_texture):
		self.texture = gun_texture
		position_weapon(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_to_mouse(self)
	flip_weapon(self)
	if (Input.is_action_just_pressed("left_click")):
		on_click()
		

func on_click() -> void:
	var bullet_ist = bullet_prefab.instantiate()
	bullet_ist.direction = get_global_mouse_position() - global_position
	bullet_ist.direction = bullet_ist.direction.normalized()
	
	bullet_ist.rotation = rotation
	bullet_ist.global_position = firepoint.global_position
	
	get_tree().root.add_child(bullet_ist)
