extends Shot_Direction
class_name Cross_Shot
func calculate_directions(cur_dir : Vector2) -> Array[Vector2]:
	var arr : Array[Vector2] = [cur_dir]
	var angles = [90, 180, 270]
	for angle in angles:
		arr.append(cur_dir.rotated(deg_to_rad(angle)))
	return arr
