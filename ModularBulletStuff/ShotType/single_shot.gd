extends Shot_Type
class_name single_shot

func create(bullet_scene: PackedScene, position : Vector2, direction : Vector2, rotation : float, scene_tree):
	var bullet_obj = bullet_scene.instantiate()
	bullet_obj.global_position = position
	bullet_obj.direction = direction
	bullet_obj.rotation = rotation
	
	scene_tree.root.add_child(bullet_obj)
