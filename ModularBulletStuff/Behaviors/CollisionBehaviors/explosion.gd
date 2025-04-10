extends coll_behavior
class_name explosion_behavior

var particles_scene : PackedScene = preload("res://ModularBulletStuff/Behaviors/CollisionBehaviors/explosion.tscn")
var explosion_hitbox : PackedScene = preload("res://scenes/bullet_stuff/bullet_explosion_hitbox.tscn")

func on_collision(bullet : player_bullet, collision : KinematicCollision2D):
	var particles : CPUParticles2D = particles_scene.instantiate()
	particles.emitting = true
	particles.one_shot = true
	particles.lifetime = 0.35
	particles.position = collision.get_position()

	bullet.get_tree().root.add_child(particles)
	var test = explosion_hitbox.instantiate()
	bullet.get_tree().root.add_child(test)
	test.create(particles.position)
	
