extends FlightBehavior
class_name Homing_Behavior
var homing_radius = 75
var enemies : Array
func _init(bullet: Node2D) -> void:
    enemies = bullet.get_tree().get_nodes_in_group("enemies")
    #print(enemies)
func Update_Flight(bullet: Node2D, _delta : float) -> void:
    enemies = bullet.get_tree().get_nodes_in_group("enemies")
    var closet_enemy
    var min_dist = 100000000000000000
    
    for enemy in enemies:
        var dist = (bullet.global_position - enemy.global_position).length()
        if (dist < homing_radius and dist < min_dist):
            min_dist = dist
            closet_enemy = enemy
    if (closet_enemy):
        var direction = (closet_enemy.global_position - bullet.global_position).normalized()
        bullet.velocity += direction * 50
        bullet.velocity = bullet.velocity.normalized() * bullet.move_speed