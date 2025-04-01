extends CharacterBody2D
class_name boid

@onready var sprite : AnimatedSprite2D = $Sprite2D
@onready var ray_folder : Array = $rayfolder.get_children()
@export var align: float = 0.6
# min distance in which a boid should steer awayfrom the others
@export var separation_dist : float
@export var separation_factor : float
var player : player_refactor
var boids_in_view : Array = []

var player_in_view: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2(randf_range(-1, 1), randf_range(-1, 1)) * randf_range(50, 100)
	rotate_to_velocity()

# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	var new_velo = Vector2.ZERO
	if (boids_in_view.size() > 0):
		#Get velocity nudges from classic boid behaviors
		new_velo += boid_behaviors()
	# Add in the behavior to avoid touching tiles
	new_velo += detect_tiles()
	
	if (player_in_view):
		# makes the boid stupidly follow the player if it is in range
		var direction = player.global_position - global_position
		direction = direction * (6/direction.length())
		velocity += direction
	
	velocity = lerp(velocity, new_velo, align * delta)
	velocity = velocity.normalized() * 100
	rotate_to_velocity()
	
	move_and_slide()

func boid_behaviors() -> Vector2:
	var avg_pos : Vector2 = Vector2.ZERO
	var avg_velo = Vector2.ZERO
	var avoidance = Vector2.ZERO
	
	for obj : boid in boids_in_view:
		avg_pos += obj.position
		avg_velo += obj.velocity
		
		avoidance -= (obj.global_position - global_position) * (100/(global_position - obj.global_position).length())
	
	avg_pos /= boids_in_view.size()
	avg_velo /= boids_in_view.size() 
	avoidance /= boids_in_view.size() 
	
	return ((avg_pos - position) / 2) * 3 + ((avg_velo - velocity) / 2) * 2 + avoidance * 0.75

func cohesion() -> Vector2:
	var avg_position : Vector2 = Vector2.ZERO
	for i in boids_in_view:
		avg_position += i.position
	
	avg_position = avg_position / (boids_in_view.size())
	
	return avg_position - position

#calculate avoidance factor
func avoidance() -> Vector2:
	var avoidance : Vector2 = Vector2.ZERO
	
	for i : boid in boids_in_view:
		var distance = global_position - i.global_position
		# smaller the distance the larger the scaling factor
		avoidance -= (i.global_position - global_position)  * (50/(distance.length()))
	
	avoidance /= boids_in_view.size()
	return avoidance

func detect_tiles() -> Vector2:
	var adjustment: Vector2 = Vector2.ZERO
	for ray : RayCast2D in ray_folder:
		#If the ray is toucing something. Assume it is a tile
		if ray.is_colliding():
			var magnitude : float = (100/(ray.get_collision_point() - global_position).length_squared())
			var angle = atan2(velocity.y, velocity.x)
			adjustment -= (ray.target_position.rotated(angle) * magnitude) / 0.025
	return adjustment




func rotate_to_velocity() -> void:
	if (velocity.x < 0):
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	#rotation = atan2(velocity.y, velocity.x) + PI/2

func average_alignment() -> Vector2:
	var avg_velocity: Vector2 = Vector2.ZERO
	for i: boid in boids_in_view:
		avg_velocity += i.velocity
	# Needed to add in your own velocity
	return avg_velocity / (boids_in_view.size())

func _on_view_area_entered(area: Area2D) -> void:
	if(area.get_parent() is boid):
		print("boid entered view!")
		boids_in_view.append(area.get_parent())


func _on_view_area_exited(area: Area2D) -> void:
	if(area.get_parent() is boid):
		print("boid exited view!")
		boids_in_view.erase(area.get_parent())


func _on_view_body_entered(body: Node2D) -> void:
	if (body is player_refactor):
		player = body
		player_in_view = true


func _on_view_body_exited(body: Node2D) -> void:
	if (body is player_refactor):
		player_in_view = false
