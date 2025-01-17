extends State
class_name enemy_follow

var player : CharacterBody2D
@export var enemy : CharacterBody2D
@export var follow_speed : float = 40.0
@export var follow_range: float = 25.0
@export var idle_transtion_range : float = 150.0


func Enter():
	player = get_tree().get_first_node_in_group("player")
	
	

func Physics_Update(delta: float):
	var direction = player.global_position - enemy.global_position
	if direction.length() > follow_range:
		enemy.velocity = direction.normalized() * follow_speed
	else:
		enemy.velocity = Vector2()
		
	if direction.length() > idle_transtion_range:
		Transitioned.emit(self, "idle")
