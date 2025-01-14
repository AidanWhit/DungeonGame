extends CharacterBody2D
class_name red_dino

@onready var sprite : AnimatedSprite2D = $"AnimatedSprite2D"
func _physics_process(delta: float) -> void:
	move_and_slide()
	
	if velocity.x > 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
	if velocity.length() > 0 and velocity.length() < 20:
		sprite.play("walk")
	elif velocity.length() >= 40:
		sprite.play("chase")
	elif (velocity == Vector2.ZERO):
		sprite.play("idle")
