extends coll_behavior
class_name explosion_behavior

var particles_scene : PackedScene
func _init() -> void:
	particles_scene = preload("res://ModularBulletStuff/Behaviors/explosion.tscn")
func on_collision(bullet : player_bullet, collision : KinematicCollision2D):
	var particles : CPUParticles2D = particles_scene.instantiate()
	particles.emitting = true
	particles.one_shot = true
	particles.lifetime = 0.35
	particles.position = collision.get_position()
	
	bullet.get_tree().root.add_child(particles)
