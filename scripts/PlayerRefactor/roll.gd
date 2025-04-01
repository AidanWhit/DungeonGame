extends State

@export var player : player_refactor
@export var roll_speed : float
var roll_direction : Vector2
var sprite2D : AnimatedSprite2D

var roll_frames : int
func Enter():
	roll_direction = player.velocity.normalized()
	
	# Could be a better way to do this
	if (roll_direction.x > 0):
		player.set_facing(player.FACING.RIGHT)
	elif(roll_direction.x < 0):
		player.set_facing(player.FACING.LEFT)
	elif (roll_direction.length() == 0): # Give an inital roll even if there was no original direction
		if (player.current_facing == player.FACING.RIGHT):
			roll_direction = Vector2(1, 0)
		else:
			roll_direction = Vector2(-1, 0)
	sprite2D = player.get_child(0)
	sprite2D.play("roll")
	
	roll_frames = sprite2D.sprite_frames.get_frame_count("roll")
	
	player.velocity = roll_direction * roll_speed


func Physics_Update(delta: float) -> void:
	player.move_and_slide()
	
	player.velocity *= 0.98
	
	if (sprite2D.frame == roll_frames - 1):
		#Allow the player to play other animations besides rolls
		sprite2D.play("idle")
		Transitioned.emit(self, "Movement")
