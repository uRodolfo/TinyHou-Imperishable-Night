extends State
class_name EnemyRetreat

@export var stop_distance : float = 50.0

@onready var _enemy: EnemyFairy = owner
@onready var _player : CharacterBody2D = get_tree().get_first_node_in_group("Player")
@onready var player_direction : Vector2

func Enter():
	#Conectar ao visible_on_screen_notifier para deletar o inimigo quando sair da tela
	var screen_notifier : VisibleOnScreenNotifier2D = _enemy.find_child("VisibleOnScreenNotifier2D")
	if screen_notifier:
		if not screen_notifier.is_connected("screen_exited", on_screen_exited):
			screen_notifier.connect("screen_exited", on_screen_exited)
	
	#Calcular a direção do player (apenas uma vez para que o jogador não possa manipular a rota de fuga do inimigo)
	player_direction = _player.global_position - _enemy.global_position     #Calcular a direção do player
	
	#Diminuir a velocidade do inimigo para recuar mais devagar
	_enemy.speed /= 3
	_enemy.acceleration /= 5

func Phyisics_Update(_delta: float):
	_enemy.move_direction = -(player_direction) #Inverter a distância do player para que o inimigo corra dele

func Exit():
	_enemy.speed = _enemy.MAX_SPEED
	_enemy.acceleration = _enemy.MAX_ACCELERATION

#Deletar inimigo quando sair da tela
func on_screen_exited():
	if _enemy:
		queue_free()
		print("deleted")
