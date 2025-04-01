extends CharacterBody2D
class_name red_dino

@onready var sprite : AnimatedSprite2D = $"AnimatedSprite2D"
@onready var kick_hitbox : Hurtbox = $"Kick_hurtbox"
var damaged = false
var kicking = false
func _ready() -> void:
	var hitbox : HitBox = $"dino_hitbox"
	hitbox.damaged.connect(play_hurt_animation)
	
	var kick_state : enemykick = $"StateMachine/Kick"
	kick_state.kick.connect(kick)

func _physics_process(_delta: float) -> void:
	move_and_slide()

	if (kicking):
		sprite.play("kick")
		if (sprite.frame == 2):
			kicking = false
		return

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
	

func kick(player: Player) -> void:
	kicking = true
	var direction = sign(player.global_position.x - global_position.x)
	
	if direction < 0:
		# move kick hitbox to the left side of the dino
		kick_hitbox.global_position.x = global_position.x - sprite.sprite_frames.get_frame_texture("kick", 1).get_width()
		sprite.flip_h = true
	else:
		kick_hitbox.global_position.x = global_position.x
		sprite.flip_h = false
