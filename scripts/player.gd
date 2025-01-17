extends CharacterBody2D
class_name Player

const SPEED = 100.0
var facing_right := true
var direction: Vector2
@onready var sprite2D : AnimatedSprite2D = $"AnimatedSprite2D"

enum FACING {LEFT = -1, RIGHT = 1}
var current_facing = FACING.RIGHT


func _physics_process(delta: float) -> void:
	get_direction()
	velocity = direction * SPEED
	flip_player()
	
	if velocity.length() > 0:
		sprite2D.play("run")
	else:
		sprite2D.play("idle")
	
	
	move_and_slide()

func get_direction():
	direction = Input.get_vector("left", "right", "up", "down")
	
func flip_player() -> void:
	var mouse_position = get_global_mouse_position()
	var facing = sign(mouse_position.x - position.x)
	
	if (facing != current_facing):
		if (facing == 1):
			sprite2D.flip_h = false
			current_facing = FACING.RIGHT
		else:
			current_facing = FACING.LEFT
			sprite2D.flip_h = true
