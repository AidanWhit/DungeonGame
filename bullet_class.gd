extends Node2D
class_name bullet

@export var move_speed : float = 200
@export var damage : float = 1
@export var pierce : int = 1

var direction : Vector2


func bullet_collision_tile(body: Node2D) -> void:
	if (body is TileMapLayer):
		queue_free()

func bullet_collision_area(area: Area2D) -> void:
	if (area is HitBox):
		var attack : Attack = Attack.new()
		attack.attack_damage = damage
		
		(area as HitBox).damage(attack)
		pierce -= 1
		if (pierce == 0):
			queue_free()
