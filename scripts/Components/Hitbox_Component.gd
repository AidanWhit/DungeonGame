extends Area2D
class_name Hitbox

@export var damage_dealt : float = 1.0

func _ready() -> void:
	area_entered.connect(on_area_entered)

func on_area_entered(area: Area2D) -> void:
	if area is Hurtbox:
		var attack : Attack = Attack.new()
		attack.attack_damage = damage_dealt

		(area as Hurtbox).damage(attack)
