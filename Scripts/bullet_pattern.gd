extends Node2D
class_name BulletPattern

func Enter() -> void:
	pass

func Exit() -> void:
	pass

func PhysicsUpdate(delta) -> void:
	pass

func Update(delta) -> void:
	pass
	
func PlayerPosition() -> Vector2:
	var player = get_tree().get_nodes_in_group("Player")

	if player[0] is Node2D:
		var p : Node2D = player[0]
		var player_position : Vector2 = p.position
		return player_position
	return Vector2.ZERO

func SetBulletCallbacks(bullet: Bullet, bc: BulletCallables) -> void:
	bullet.set_onReady_callback(bc.OnReadyCallable())
	bullet.set_physicsUpdate_callback(bc.PhysicsUpdateCallable())
	bullet.set_update_callback(bc.UpdateCallable())
	
