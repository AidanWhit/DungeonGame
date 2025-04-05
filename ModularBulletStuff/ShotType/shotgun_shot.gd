extends Shot_Type
class_name Shotgun_Shot

func create(bullet_scene : PackedScene, position: Vector2, direction : Vector2, rotation : float, scene_tree) -> void:
	var angles := [-10, -5, 0, 5, 10]
	
	for angle in angles:
		var bullet_obj = bullet_scene.instantiate()
		bullet_obj.global_position = position
		bullet_obj.direction = direction.rotated(deg_to_rad(angle))
		bullet_obj.rotation = rotation
		
		scene_tree.root.add_child(bullet_obj)
