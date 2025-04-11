extends ProgressBar

@export var health : HealthComponent
var displayed_health : int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (health):
		max_value = health.max_health
		displayed_health = health.max_health
		value = displayed_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (health):
		if (displayed_health != health.current_health):
			print("health lowered")
			displayed_health = health.current_health
			value = displayed_health
