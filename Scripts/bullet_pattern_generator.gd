extends Node2D

@export var bullet_build_component : BulletBuildComponent     #Construtor de balas
@export var bullet_callbacks : BulletCallablesStrategy = BulletCallablesStrategy.new() #Funções que serão executadas durante o tempo de vida da bala
@export var bp_res : BulletPatternRes = BulletPatternRes.new()

var _angle_between_bullets : float = 0.0
var _counter_seconds_left : float = 0.0
var _bullet_pattern_rotation : float = 0.0

func Enter() -> void:
	if bp_res.is_spread_radial or bp_res.spread_angle_deg == 360:
		_angle_between_bullets = (2 * PI) / bp_res.number_of_bullets
	else:
		if bp_res.number_of_bullets > 1:
			_angle_between_bullets = deg_to_rad(bp_res.spread_angle_deg) / (bp_res.number_of_bullets - 1)
	
	_bullet_pattern_rotation += bp_res.initial_rotation

func Emit_bullets(delta) -> void:
	#Calcular a rotação dos tiros com base no tempo passado
	_bullet_pattern_rotation += bp_res.rotation_speed * delta
	_bullet_pattern_rotation = fmod(_bullet_pattern_rotation, 360)
	
	#Timer para contar os segundos entre cada tiro
	_counter_seconds_left -= delta
	if _counter_seconds_left <= 0:
		_counter_seconds_left = bp_res.seconds_between_shots
		
		for i in range(bp_res.number_of_bullets):
			var b = bullet_build_component.build_bullet()
			
			var bullet_rotation : float
			var bullet_pos : Vector2
			
			if bp_res.is_spread_radial:     #Calcular rotação e posição das balas para atirar em 360
				print(_bullet_pattern_rotation)
				bullet_rotation = _angle_between_bullets * i + (PI/2) + deg_to_rad(_bullet_pattern_rotation) #Calcular rotação das balas com base no número de balas
				bullet_pos = (Vector2.RIGHT.rotated(bullet_rotation) * bp_res.spawn_radius)    #Calcular posição das balas com base na sua rotação e spawn radius
			
			else:
				var offset : float = deg_to_rad(bp_res.spread_angle_deg) / 2
				bullet_rotation = (_angle_between_bullets * i) - offset + deg_to_rad(_bullet_pattern_rotation)
				bullet_pos = (Vector2.RIGHT.rotated(bullet_rotation) * bp_res.spawn_radius)

			#Transforms
			match bp_res.bullets_direction:
				"None":
					b.position += bullet_pos
					b.rotation += bullet_rotation
				"Pattern to Player":
					var player_direction : float = global_position.angle_to_point(PlayerPosition())
					if !bp_res.is_spread_radial:
						b.position += bullet_pos.rotated((player_direction))
						b.rotation = player_direction + bullet_rotation
					else:
						b.position += bullet_pos
						b.rotation = player_direction
						
				"Bullet to Player":
					var player_direction : float = global_position.angle_to_point(PlayerPosition())
					if !bp_res.is_spread_radial:
						b.position += bullet_pos.rotated((player_direction))
						b.rotation = b.position.angle_to_point(PlayerPosition())
					else:
						b.position += bullet_pos
						b.rotation = b.position.angle_to_point(PlayerPosition())
			b.speed = bp_res.bullets_speed
			
			SetBulletCallbacks(b, bullet_callbacks) #Passar as funções que serão executadas no tempo de vida da bala
			
			get_tree().current_scene.add_child.call_deferred(b)

func PlayerPosition() -> Vector2:
	var player = get_tree().get_nodes_in_group("Player")

	if player.size() > 0:
		if player[0] is Node2D:
			var p : Node2D = player[0]
			var player_position : Vector2 = p.position
			return player_position
	return Vector2.ZERO

func SetBulletCallbacks(bullet: Bullet, bc: BulletCallablesStrategy) -> void:
	bullet.set_onReady_callback(bc.OnReadyCallable())
	bullet.set_physicsUpdate_callback(bc.PhysicsUpdateCallable())
	bullet.set_update_callback(bc.UpdateCallable())
