extends Node
class_name BulletCallables

#Métodos para setar as funções anônimas
func UpdateCallable() -> Callable:
	var cb = func BlankUpdate(caller, delta):
		pass
	return cb
	
func PhysicsUpdateCallable() -> Callable:
	var cb = func BlankPhysicsUpdate(caller, delta):
		pass
	return cb
	
func OnReadyCallable() -> Callable:
	var cb = func BlankOnReady(caller):
		pass
	return cb
