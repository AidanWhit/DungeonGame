extends CharacterBody2D
class_name red_dino

@onready var sprite : AnimatedSprite2D = $"AnimatedSprite2D"
var damaged = false
func _ready() -> void:
	var hitbox : HitBox = $"dino_hitbox"
	hitbox.damaged.connect(play_hurt_animation)

func _physics_process(_delta: float) -> void:
	move_and_slide()
	
	if velocity.x > 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
	
	# probably a better way to do this
	if (damaged):
		sprite.play("damaged")
		if (sprite.frame == 2):
			damaged = false
		return
	
	if velocity.length() > 0 and velocity.length() < 20:
		sprite.play("walk")
	elif velocity.length() >= 40:
		sprite.play("chase")
	elif (velocity == Vector2.ZERO):
		sprite.play("idle")

func play_hurt_animation() -> void:
	damaged = true
	
