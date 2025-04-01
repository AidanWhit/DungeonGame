extends State

@export var player : CharacterBody2D
@export var speed : float

func Physics_Update(delta : float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	player.velocity = direction * speed
	
	player.move_and_slide()
	if (Input.is_action_just_pressed("roll")):
		Transitioned.emit(self, "Roll")
