extends CharacterBody2D
class_name player_bullet

@export var move_speed : float = 200.0
@export var damage : float = 1.0
@export var pierce : int = 1

var destroy_on_coll : bool = true
var direction

var collision_behaviors : Array = [bouncing_behavior.new(self)]
var flight_behaviors : Array[FlightBehavior] = []
var worm_affect : FlightBehavior = Squiggle_Flight.new()
func _ready() -> void:
	velocity = move_speed * direction



func _physics_process(delta: float) -> void:
	#velocity = move_speed * direction

	var collision = move_and_collide(velocity * delta)
	for behavior in flight_behaviors:
		behavior.Update_Flight(self, delta)
	# enemies could have a hit method that can detected using the collison object. 
	if worm_affect:
		worm_affect.Update_Flight(self, delta)
	if collision:
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
