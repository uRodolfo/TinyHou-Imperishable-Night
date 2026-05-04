extends Resource
class_name WaveData

@export var wave_name: String = "NULL"
@export var enemy_scene: PackedScene
@export var quantity : int = 1
@export var spawn_interval: float = 0.0
@export var spawn_position_1 : Vector2 = Vector2(0.0, -64.0)
@export var spawn_position_2 : Vector2 = Vector2(256, -128.0)  #Use para aleatorizar o spawn dos inimigos entre a posição 1 e 2
