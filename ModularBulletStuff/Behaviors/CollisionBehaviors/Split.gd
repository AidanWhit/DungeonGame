extends coll_behavior
class_name Splitting_Behavior

func on_collision(bullet, collision : KinematicCollision2D) -> void:
	# This script may only work for the player since the player's bullet and enemies's bullet behaviors are structered differently
	# Could be changed so that the player's bullets also use resources
	var coll_normal = collision.get_normal()
	# could have splits be perpedicular, or cross. Might make a script for either to add variation 
	var split_angles = [deg_to_rad(-45), deg_to_rad(45)]
	for angle in split_angles:

		#var new_bullet = clone(bullet, coll_normal.rotated(angle))
		var new_bullet = Clone.clone(bullet, coll_normal.rotated(angle), self)
		# Remove splitting so infinite splits can't happen
		bullet.get_tree().root.add_child(new_bullet)
