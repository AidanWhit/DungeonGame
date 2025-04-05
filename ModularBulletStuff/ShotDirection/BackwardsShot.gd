extends Shot_Direction
class_name Backward_Shot
func calculate_directions(cur_dir : Vector2) -> Array[Vector2]:
	var arr : Array[Vector2] = []
	arr.append(cur_dir)
	arr.append(cur_dir.rotated(deg_to_rad(180)))
	return arr
