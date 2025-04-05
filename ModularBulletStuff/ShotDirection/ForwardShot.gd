extends Shot_Direction
class_name ForwardShot

# Might want to delete this class and have it be the default behavior instead within the gun class
func calculate_directions(cur_dir : Vector2) -> Array:
	var arr = []
	arr.append(cur_dir)
	return arr
