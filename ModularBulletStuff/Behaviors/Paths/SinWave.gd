extends FlightBehavior
class_name Squiggle_Flight
var time_elapsed = 0
var direction = Vector2.RIGHT
func Update_Flight(bullet : Node2D, delta: float) -> void:
    time_elapsed += delta
    # Get perpendicular vector to current velocity
    var perpendicular = bullet.velocity.orthogonal().normalized()
    var slope_tangent_to_sin = cos(time_elapsed * 12) * 35
    var offset = perpendicular * slope_tangent_to_sin

    bullet.velocity += offset

    