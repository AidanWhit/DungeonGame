extends Node2D
class_name bullet

@export var move_speed : float = 10.0
@export var damage : float = 1.0

var direction : Vector2


func _physics_process(delta: float) -> void:
	position += direction * move_speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if (area is HitBox):
		var hitbox : HitBox = area as HitBox
		var attack : Attack = Attack.new()
		attack.attack_damage = damage
		
		hitbox.damage(attack)
		
		queue_free()
