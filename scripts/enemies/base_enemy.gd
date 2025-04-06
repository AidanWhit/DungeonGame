extends Node2D
class_name base_enemy

@export var stats : enemy_stats


func on_hit(damage) -> void:
    var padding = Vector2(randi_range(-10, 10), randi_range(-10, 10))
    var pos = Vector2(global_position.x, global_position.y - 24) + padding
    DamageNumbers.display_number(damage, pos)