extends Shot_Type
class_name Tri_Shot
func create(bullet_scene : PackedScene, pos : Vector2, dir : Vector2, rotation : float, scene_tree) -> void:
    var angles = [-25, 0, 25]
    for angle in angles:
        var bullet_obj = bullet_scene.instantiate()
        bullet_obj.direction = dir.rotated(deg_to_rad(angle))
        bullet_obj.global_position = pos
        bullet_obj.rotation = rotation

        scene_tree.root.add_child(bullet_obj)