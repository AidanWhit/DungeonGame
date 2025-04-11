extends StaticBody2D

@export var bullet_prefab : Enemy_Bullet_Data
var player : player_refactor
var inside_area : bool
const time_between_shots : int = 5
var time_elapsed : float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if inside_area:
		time_elapsed += delta
		if time_elapsed >= time_between_shots:
			time_elapsed = 0
			var direction : Vector2 = (player.global_position - global_position).normalized()
			var bullet : Base_Enemy_Bullet = bullet_prefab.bullet_scene.instantiate()
			bullet.bullet_properties = bullet_prefab.properties.duplicate()
			bullet.direction = direction
			bullet.global_position = global_position
			get_tree().root.add_child(bullet)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is player_refactor:
		inside_area = true
		#Make it so that the player is immediately shot at once they enter the area
		#time_elapsed = time_between_shots


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is player_refactor:
		inside_area = false
		#time_elapsed = 0
