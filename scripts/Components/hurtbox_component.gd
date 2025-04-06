extends Area2D
class_name Hurtbox

@export var health_component : HealthComponent

signal damaged

func damage(attack : Attack):
	if (health_component):
		health_component.damage(attack)
		damaged.emit(attack.attack_damage)
