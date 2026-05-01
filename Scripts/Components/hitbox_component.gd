extends Area2D
class_name HitboxComponent

@export var health_component : HealthComponent

func damage(damage: float):
	if health_component:
		health_component.damage(damage)
