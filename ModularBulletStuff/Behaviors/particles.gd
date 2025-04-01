extends CPUParticles2D

func _ready() -> void:
	finished.connect(destroy_particle)

func destroy_particle() -> void:
	print("Entered destroy")
	queue_free()
