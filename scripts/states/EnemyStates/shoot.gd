extends State

@export var enemy : CharacterBody2D
@export var enemy_weapon : Sprite2D
@export var move_speed : float = 40.0
@export var shooting_range : float = 250.0
@export var bullet_prefab : PackedScene
@export var time_between_shot : float = 5.0
var bullet_instance : bullet
var player : Player
var move_direction : Vector2
var timer : Timer = Timer.new()
func Enter() -> void:
	if (bullet_prefab):
		bullet_instance = bullet_prefab.instantiate()
	player = get_tree().get_first_node_in_group("player")
	get_parent().add_sibling(timer)
	timer.wait_time = time_between_shot
	timer.timeout.connect(Shoot)
	timer.start()


func Update(delta: float) -> void:
	var distance_to_player : Vector2 = (player.global_position - enemy.global_position)
	
	enemy_weapon.look_at(player.global_position)
	if (distance_to_player.x < 0):
		enemy_weapon.global_rotation += PI
	enemy.velocity = distance_to_player.normalized() * move_speed
	
	
	if (distance_to_player.length() > shooting_range):
		Transitioned.emit(self, "idle")

func Shoot() -> void:
	bullet_instance = bullet_prefab.instantiate()
	
	bullet_instance.move_speed = 50
	bullet_instance.global_position = enemy.global_position
	bullet_instance.direction = player.global_position - enemy.global_position
	bullet_instance.direction = bullet_instance.direction.normalized()
	bullet_instance.global_rotation = enemy_weapon.global_rotation
	
	get_tree().root.add_child(bullet_instance)
