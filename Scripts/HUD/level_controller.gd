extends Control

var _player: Node = null

func _ready():
	_player = get_tree().get_first_node_in_group("Player")

func _physics_process(delta: float) -> void:
	if _player:
		print("Vida atual: ", _player.health_component.health)  # Veja o valor
		if _player.health_component.health <= 0:
			handle_gameover()

func handle_gameover():
	get_tree().change_scene_to_file("res://Scenes/GameOver.tscn")
