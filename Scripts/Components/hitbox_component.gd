extends Area2D
class_name HitboxComponent

@export var health_component : HealthComponent

func damage(bullet: Bullet):
	if health_component:
		health_component.damage(bullet.damage)
		bullet.queue_free()
