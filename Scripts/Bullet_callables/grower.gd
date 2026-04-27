extends BulletCallables

func PhysicsUpdateCallable() -> Callable:
	var growing_per_step = 1
	var bc = func(caller, delta):
		var grow = growing_per_step * delta
		caller.scale += Vector2(grow, grow)
	return bc
