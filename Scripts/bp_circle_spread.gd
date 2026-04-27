extends BulletPattern

@export var bullet_build_component : BulletBuildComponent     #Construtor de balas
@export var bullet_call_backs : BulletCallables = BulletCallables.new()    #Funções que serão executadas durante o tempo de vida da bala

@export var number_of_bullets := 8
@export var spawn_radius := 0
@export var rotation_speed := 0.0
@export var initial_rotation := 0
@export var seconds_between_shots := 0.1
@export_enum("Radial", "Pattern to Player", "Bullet to Player") var bullets_direction : String = "Radial"

@onready var _rotation_per_bullet = (2 * PI) / number_of_bullets
var _counter_seconds_left := 0.0
var _bullet_pattern_rotation := 0.0

func Enter() -> void:
	_bullet_pattern_rotation += initial_rotation

func Update(delta) -> void:
	#Calcular a rotação dos tiros com base no tempo passado
	_bullet_pattern_rotation += rotation_speed * delta
	_bullet_pattern_rotation = fmod(_bullet_pattern_rotation, 360)
	
	#Timer para contar os segundos entre cada tiro
	_counter_seconds_left -= delta
	if _counter_seconds_left <= 0:
		_counter_seconds_left = seconds_between_shots
		
		#Lógica de spawnar tiros
		#Dividimos o ângulo de um circulo inteiro (2PI) pelo numero de balas a serem spawnadas para determinar o angulo entre cada uma
		#Após isso, aplicamos o ângulo a cada iteração das balas, reduzindo PI/2 para que fiquem alinhadas com o eixo Y
		#Por fim, adicionamos a rotação calculada anteriormente para simular um padrão de balas que roda com o tempo
		for i in range(number_of_bullets):
			var b = bullet_build_component.build_bullet()
			var bullet_rotation = _rotation_per_bullet * i - (PI/2) + deg_to_rad(_bullet_pattern_rotation)    #Calcular rotação das balas com base no número de balas
			var bullet_pos = (Vector2.RIGHT.rotated(bullet_rotation) * spawn_radius)    #Calcular posição das balas com base na sua rotação e spawn radius
			
			#Transforms
			match bullets_direction:
				"Radial":
					b.position += bullet_pos
					b.rotation += bullet_rotation
				"Pattern to Player":
					b.rotation = b.position.angle_to_point(PlayerPosition())
					b.position += bullet_pos
				"Bullet to Player":
					b.position += bullet_pos
					b.rotation = b.position.angle_to_point(PlayerPosition())
			
			SetBulletCallbacks(b, bullet_call_backs) #Passar as funções que serão executadas no tempo de vida da bala
			
			get_tree().current_scene.add_child.call_deferred(b)
