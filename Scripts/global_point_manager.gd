extends Node

var points: int = 0
var player_health : int = 3

func add_points(value: int):
	points += value
	print("Pontos agora: ", points)

func spawn_point(posicao: Vector2):
	var point = preload("res://Scenes/PlayerCollectables/point.tscn").instantiate()
	point.position = posicao
	point.colided.connect(_on_point_colided)
	get_tree().current_scene.add_child(point)

func _on_point_colided():
	add_points(10)
	print(points)
