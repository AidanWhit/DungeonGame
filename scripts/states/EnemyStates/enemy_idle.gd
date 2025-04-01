extends State
class_name enemy_idle

@export var enemy: CharacterBody2D
@export var move_speed : float = 10.0
@export var start_transition : float = 40.0
@export var transition_state : String = "follow"
var player : CharacterBody2D

var move_direction : Vector2
var wander_time : float

func randomize_wander():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1 , 1))
	wander_time = randf_range(1, 3)

func Enter():
	randomize_wander()
	
	player = get_tree().get_first_node_in_group("player")
	
	enemy.get

func Update(delta: float):
	if (wander_time > 0):
		wander_time -= delta
	else:
		randomize_wander()

func Physics_Update(delta: float):
	if (enemy):
		enemy.velocity = move_direction * move_speed
		
	var direction = player.global_position - enemy.global_position
	if direction.length() < start_transition:
		Transitioned.emit(self, transition_state)
