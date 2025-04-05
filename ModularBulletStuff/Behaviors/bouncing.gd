extends coll_behavior
class_name bouncing_behavior
var bounces_left = 3

func _init(bullet: player_bullet) -> void:
	bullet.set_destroy_on_coll(false)

# Could possibly change to be static functions so I don't have to create a new object
func on_collision(bullet : player_bullet, collision : KinematicCollision2D) -> void:
	bullet.velocity = bullet.velocity.bounce(collision.get_normal())
	bounces_left -= 1
	if bounces_left == 0:
		bullet.queue_free()
