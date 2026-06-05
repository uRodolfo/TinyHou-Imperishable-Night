extends BulletCallablesStrategy
class_name GrowerCallableStrategy

@export var growing_per_step : float = 1

func PhysicsUpdateCallable() -> Callable:
	var bc = func(caller : Enemy_bullet, delta):
		var grow = growing_per_step * delta
		caller.scale += Vector2(grow, grow)
	return bc
