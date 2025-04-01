extends CharacterBody2D
class_name player_refactor
var sprite2D : AnimatedSprite2D

enum FACING {LEFT = -1, RIGHT = 1}
# Assume player starts facing the right
var current_facing : FACING = FACING.RIGHT

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite2D = get_node("sprite")

func _physics_process(delta: float) -> void:
	
	
	if (sprite2D.animation != "roll"):
		flip_player()
		if (velocity.length() > 0):
			sprite2D.play("run")
		else:
			sprite2D.play("idle")
	
	#print("Animation Playing: " + sprite2D.animation)

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

func set_facing(facing: FACING) -> void:
	current_facing = facing
	if (facing == FACING.RIGHT):
		sprite2D.flip_h = false;
	else:
		sprite2D.flip_h = true
