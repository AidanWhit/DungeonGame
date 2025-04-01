extends bullet

func _physics_process(delta: float) -> void:
	position += direction * move_speed * delta


func _on_body_entered(body: Node2D) -> void:
	bullet_collision_tile(body)


func _on_area_entered(area: Area2D) -> void:
	bullet_collision_area(area)
