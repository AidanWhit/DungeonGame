extends Area2D
class_name HitBox

@export var health_component : HealthComponent

signal damaged

func damage(attack: Attack):
	if (health_component):
		health_component.damage(attack)
		damaged.emit()
