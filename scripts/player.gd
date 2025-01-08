extends CharacterBody2D


const SPEED = 150.0
var facing_right := true
var direction: Vector2
@onready var sprite2D : AnimatedSprite2D = $"AnimatedSprite2D"


func _physics_process(delta: float) -> void:
	get_direction()
	velocity = direction * SPEED
	flip_player()
	
	
	move_and_slide()

func get_direction():
	direction = Input.get_vector("left", "right", "up", "down")
	
func flip_player() -> void:
	var mouse_position = get_global_mouse_position()
	var facing = sign(mouse_position.x - position.x)
	if (facing == 1 != facing_right):
		if (facing == 1):
			sprite2D.flip_h = false
			facing_right = true
		else:
			facing_right = false
			sprite2D.flip_h = true
