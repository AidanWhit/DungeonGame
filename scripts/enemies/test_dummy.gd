extends CharacterBody2D

@export var stats : enemy_stats
func _ready() -> void:
	if (stats.health == -1):
		stats.health = 9223372036854775807 # max_int
	
	var health_component : HealthComponent = get_node("HealthComponent")
	health_component.max_health = stats.health
	health_component.current_health = stats.health
	
	var hurtbox : Hurtbox = get_node("Hurtbox")
	hurtbox.damaged.connect(on_hit)


func on_hit(damage) -> void:
	var padding = Vector2(randi_range(-10, 10), randi_range(-10, 10))
	var pos = Vector2(global_position.x, global_position.y - 24) + padding
	DamageNumbers.display_number(damage, pos)
