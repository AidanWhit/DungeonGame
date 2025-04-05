extends FlightBehavior
class_name Follow_Mouse_Behavior

var time_to_live : float = 4.0
const follow_strength : float = 30.0
func Update_Flight(bullet : Node2D, delta: float) -> void:

    time_to_live -= delta
    if (time_to_live < 0):
        bullet.queue_free()
    # Version 1
    var dir_to_mouse = (bullet.get_global_mouse_position() - bullet.global_position).normalized()
    bullet.velocity += dir_to_mouse * follow_strength
    bullet.velocity = bullet.velocity.normalized() * bullet.move_speed


