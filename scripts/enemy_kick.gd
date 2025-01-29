extends State
class_name enemykick

@export var enemy: CharacterBody2D
var player : CharacterBody2D

@export var hurtbox : Hurtbox
var sprite: AnimatedSprite2D
var collision_shape : CollisionShape2D
signal kick

func Enter():
	sprite = enemy.get_node("AnimatedSprite2D")
	if (hurtbox):
		collision_shape = hurtbox.get_child(0)
		collision_shape.disabled = false
	player = get_tree().get_first_node_in_group("player")
	enemy.velocity = Vector2()
	kick.emit(player)

func Update(delta: float) -> void:
	if ("kicking" in enemy):
		var kicking : bool = enemy.get("kicking")
		if kicking == false:
			collision_shape.disabled = true
			Transitioned.emit(self, "idle")
