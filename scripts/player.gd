extends CharacterBody2D


const SPEED = 150.0
var facing_right := true
var direction: Vector2
@onready var sprite2D : AnimatedSprite2D = $"AnimatedSprite2D"
@onready var weaponSprite: Sprite2D = $"weapon"

enum FACING {LEFT = -1, RIGHT = 1}
var current_facing = FACING.RIGHT
func _ready() -> void:
	if (weaponSprite):
		set_weapon_position(FACING.RIGHT)

func _process(delta: float) -> void:
	rotate_weapon()

func rotate_weapon() -> void:
	var rotation_direction : Vector2 = get_global_mouse_position() - weaponSprite.global_position
	var rotation = atan2(rotation_direction.y, rotation_direction.x)
	rotation *= 180 / PI
	weaponSprite.rotation_degrees = rotation

	if (current_facing == FACING.LEFT):
		weaponSprite.rotation_degrees += 180
	var node: Marker2D = weaponSprite.get_child(0)

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
			weaponSprite.flip_h = false
			current_facing = FACING.RIGHT
		else:
			current_facing = FACING.LEFT
			weaponSprite.flip_h = true
			sprite2D.flip_h = true
		
		set_weapon_position(current_facing)
	
func set_weapon_position(facing: FACING) -> void:
	var sprite_size = weaponSprite.texture.get_size()
	if (current_facing == FACING.RIGHT):
		weaponSprite.global_position.x = global_position.x + sprite_size.x
	else:
		weaponSprite.global_position.x = global_position.x - sprite_size.x
	weaponSprite.global_position.y = global_position.y + sprite_size.y / 2
