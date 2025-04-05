extends CharacterBody2D
class_name player_bullet

@export var move_speed : float = 200.0
@export var damage : float = 1.0
@export var pierce : int = 1

var destroy_on_coll : bool = true
var direction

var collision_behaviors : Array = []
var flight_behaviors : Array[FlightBehavior] = []
func _ready() -> void:
	velocity = move_speed * direction
	add_collision_behavior(explosion_behavior.new())
	add_collision_behavior(bouncing_behavior.new(self))
	add_flight_behavior(Follow_Mouse_Behavior.new())


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	for behavior in flight_behaviors:
		behavior.Update_Flight(self, delta)
	# enemies could have a hit method that can detected using the collison object. 
	if collision:
		# execute additional behaviors
		for i in collision_behaviors:
			(i as coll_behavior).on_collision(self, collision)

		if destroy_on_coll:
			queue_free()

func add_collision_behavior(behavior: coll_behavior):
	collision_behaviors.append(behavior)

func add_flight_behavior(behavior : FlightBehavior) -> void:
	flight_behaviors.append(behavior)

func set_destroy_on_coll(val : bool):
	destroy_on_coll = val
