extends coll_behavior
class_name Cross_Split

func on_collision(bullet, collision : KinematicCollision2D):
    var coll_normal : Vector2 = collision.get_normal()
    var angles : Array = [-135, 45, -45, 135]

    for angle in angles:
        var new_bullet = Clone.clone(bullet, coll_normal.rotated(deg_to_rad(angle)), self)

        bullet.get_tree().root.add_child(new_bullet)