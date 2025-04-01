extends bullet
class_name tri_shot

var can_replicate : bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Currently a workaround, need to find a better way
	if (can_replicate):
		var left_direction  = direction.rotated(deg_to_rad(-15))
		var right_direction  = direction.rotated(deg_to_rad(15))
		replicate(left_direction)
		replicate(right_direction)

func _physics_process(delta: float) -> void:
	position += direction * move_speed * delta

func _on_body_entered(body: Node2D) -> void:
	bullet_collision_tile(body)

func _on_area_entered(area: Area2D) -> void:
	if (area.get_parent() is not Player):
		bullet_collision_area(area)


func replicate(new_direction: Vector2):
	var tri_shot_scene = preload("res://scenes/bullet_types/tri_shot.tscn")
	var new_bullet : tri_shot = tri_shot_scene.instantiate()
	
	new_bullet.direction = new_direction
	new_bullet.global_position = global_position
	new_bullet.rotation = get_angle_to(new_direction) - rotation
	new_bullet.can_replicate = false
	
	get_tree().root.add_child(new_bullet)
