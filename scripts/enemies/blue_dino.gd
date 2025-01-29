extends CharacterBody2D
class_name blue_dino


@onready var sprite : AnimatedSprite2D = $"AnimatedSprite2D"
@onready var dino_gun : Sprite2D = $"weapon"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# will abstract functionality later to be within the weapon script
func _physics_process(delta: float) -> void:
	move_and_slide()
	
	if (velocity.x > 0):
		sprite.flip_h = false
		dino_gun.flip_h = false
		dino_gun.global_position.x = global_position.x
		#dino_gun.global_rotation = velocity.angle()
	else:
		sprite.flip_h = true
		dino_gun.flip_h = true
		dino_gun.global_position.x = global_position.x - dino_gun.texture.get_width()
		#dino_gun.global_rotation = velocity.angle() + PI
	
	if (velocity.x > 0):
		sprite.play("walk")
