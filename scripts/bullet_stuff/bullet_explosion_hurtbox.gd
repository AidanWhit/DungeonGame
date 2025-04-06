extends Node2D

func create(position: Vector2) -> void:
	var collision_shape : CollisionShape2D = get_node("Hitbox/CollisionShape2D")
	collision_shape.global_position = position
	var shape : CircleShape2D = CircleShape2D.new()
	shape.radius = 20
	collision_shape.shape = shape
	var timer : Timer = Timer.new()
	add_child(timer)
	timer.wait_time = 0.5
	timer.start(0.5)
	timer.timeout.connect(destroy)

func destroy() -> void:
	queue_free()
