extends Node
class_name Clone

# Could be a decent idea
static func clone(bullet, new_dir : Vector2, caller):
	var new_bullet = bullet.duplicate()
	new_bullet.collision_behaviors = []
	#print(new_bullet.flight_behaviors)
	new_bullet.direction = new_dir
	# Create new behavior objects for the new bullet
	for i in range(len(bullet.collision_behaviors)):
		if (bullet.collision_behaviors[i].get_script() == caller.get_script()):
			continue
		new_bullet.collision_behaviors.append(bullet.collision_behaviors[i].get_script().new(new_bullet))
	
	for i in range(len(bullet.flight_behaviors)):
		new_bullet.flight_behaviors.append(bullet.flight_behaviors[i].get_script().new())
	new_bullet.destroy_on_coll = bullet.destroy_on_coll

	return new_bullet
