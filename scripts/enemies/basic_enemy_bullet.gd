extends CharacterBody2D
class_name Base_Enemy_Bullet

var bullet_properties : Enemy_Bullet_Properties
var direction : Vector2
var destroy_on_coll : bool = true
@onready var hitbox : Hitbox = $Hitbox
func _ready() -> void:
	velocity = bullet_properties.move_speed * direction
	hitbox.damage_dealt = bullet_properties.damage
	# See if there is a better way to do this
	# Could define a method within the resource maybe
	for i in len(bullet_properties.collision_behaviors):
		bullet_properties.collision_behaviors[i] = bullet_properties.collision_behaviors[i].new(self)


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		for behavior in bullet_properties.collision_behaviors:
			(behavior as coll_behavior).on_collision(self, collision)
		if destroy_on_coll:
			queue_free()

func set_destroy_on_coll(val : bool) -> void:
	destroy_on_coll = val
