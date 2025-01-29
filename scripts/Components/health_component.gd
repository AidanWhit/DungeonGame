extends Node2D
class_name HealthComponent

@export var max_health : float
var current_health
func _ready() -> void:
	current_health = max_health

func damage(attack: Attack):
	current_health -= attack.attack_damage
	
	if (current_health <= 0):
		# change this to send a signal to the parent to decide what to do 
		get_parent().queue_free()
