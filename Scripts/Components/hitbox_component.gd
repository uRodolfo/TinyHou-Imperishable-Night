extends Area2D
class_name HitboxComponent

@export var health_component : HealthComponent

func damage(player_bullet: PlayerBullet):
	if health_component:
		health_component.damage(player_bullet.damage)
		player_bullet.queue_free()
