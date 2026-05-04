extends Node

@export var waves : Array[WaveData]

@onready var enemy_spawn_player : AnimationPlayer = $EnemySpawnPlayer  #AnimationPlayer que cuida do timing das waves

var current_wave : int = 0

func _ready() -> void:
	start_next_wave()
	enemy_spawn_player.play("Enemy_Spawn_Player")

func start_next_wave() -> void:
	if current_wave < waves.size():
		var data = waves[current_wave]
		spawn_wave(data)
		current_wave += 1

func spawn_wave(wave_data : WaveData) -> void:
	print ("Iniciando: ", wave_data.wave_name)
	
	for i in range(wave_data.quantity):
		var enemy = wave_data.enemy_scene.instantiate()
		
		#Randomizar a posição do inimigo caso haja um valor diferente de (0,0) em spawn_position_2
		var enemy_position : Vector2
		if wave_data.spawn_position_2 != Vector2.ZERO:
			var enemy_pos_x : float = randf_range(wave_data.spawn_position_1.x, wave_data.spawn_position_2.x)
			var enemy_pos_y : float = randf_range(wave_data.spawn_position_1.y, wave_data.spawn_position_2.y)
			enemy_position = Vector2(enemy_pos_x, enemy_pos_y)
		else:
			enemy_position = wave_data.spawn_position_1
		enemy.position = enemy_position
		
		get_tree().current_scene.add_child.call_deferred(enemy)
		
		#Se a wave tiver um intervalo entre spawns, esperar até executar a próxima iteração
		if wave_data.spawn_interval > 0:
			await get_tree().create_timer(wave_data.spawn_interval).timeout
