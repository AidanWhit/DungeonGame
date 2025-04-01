extends CharacterBody2D

@export var move_speed : float = 200.0
@export var damage : float = 1.0
@export var pierce : int = 1

var direction : Vector2

func _ready() -> void:
	velocity = move_speed * direction

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)

	if collision:
		velocity = velocity.bounce(collision.get_normal())
		velocity = velocity.normalized() * move_speed

		

	
