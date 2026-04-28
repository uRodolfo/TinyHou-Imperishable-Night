extends BulletCallablesStrategy
class_name GrowerCallableStrategy

func PhysicsUpdateCallable() -> Callable:
	var growing_per_step = 1
	var bc = func(caller : Enemy_bullet, delta):
		var grow = growing_per_step * delta
		caller.scale += Vector2(grow, grow)
	return bc
