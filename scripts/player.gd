extends CharacterBody2D
class_name Player

const SPEED = 100.0
var facing_right := true
var direction: Vector2
@onready var sprite2D : AnimatedSprite2D = $"AnimatedSprite2D"

enum FACING {LEFT = -1, RIGHT = 1}
var current_facing = FACING.RIGHT
var damaged : bool = false

func _ready() -> void:
	if (has_node("HitBoxComponent")):
		var hitbox : HitBox = get_node("HitBoxComponent")
		hitbox.damaged.connect(take_damage)

func _physics_process(delta: float) -> void:
	get_direction()
	velocity = direction * SPEED
	flip_player()
	
	move_and_slide()
	
	if(damaged):
		sprite2D.play("damaged")
		if (sprite2D.frame == 4):
			damaged = false
		return
	if velocity.length() > 0:
		sprite2D.play("run")
	else:
		sprite2D.play("idle")

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

func take_damage() -> void:
	damaged = true
