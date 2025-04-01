extends Sprite2D
class_name player_weapon

@onready var player : player_refactor = get_owner()

var current_facing = player.FACING.RIGHT

func position_weapon(sprite: Node2D) -> void:
	sprite.global_position.x = player.global_position.x + sprite.texture.get_width()
	sprite.global_position.y = player.global_position.y + sprite.texture.get_height() / 2

func rotate_to_mouse(object: Sprite2D) -> void:
	var mouse_position = get_global_mouse_position()
	var rotation_direction = mouse_position - object.global_position
	var rotation_radians = atan2(rotation_direction.y, rotation_direction.x)

	if player.current_facing == player.FACING.LEFT:
		rotation_radians += PI
	
	object.rotation = rotation_radians
	
	flip_weapon(object)

func flip_weapon(weapon: Sprite2D) -> void:
	if (current_facing != player.current_facing):
		current_facing = player.current_facing
		weapon.flip_h = !(player.current_facing + 1)
		
		set_weapon_position(weapon)

func set_weapon_position(weapon: Sprite2D) -> void:
	if (current_facing == player.FACING.RIGHT):
		weapon.global_position.x = player.global_position.x + weapon.texture.get_width()
	else:
		weapon.global_position.x = player.global_position.x - weapon.texture.get_width()
	weapon.global_position.y = player.global_position.y + weapon.texture.get_height() / 2

func on_click() -> void:
	pass
