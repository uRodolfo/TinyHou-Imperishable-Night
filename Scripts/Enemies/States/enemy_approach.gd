extends State
class_name EnemyApproach

@onready var _enemy: EnemyFairy = owner
@onready var _player : CharacterBody2D = get_tree().get_first_node_in_group("Player")
@onready var _screen_notifier : VisibleOnScreenNotifier2D = owner.find_child("VisibleOnScreenNotifier2D")

var stop_distance : float = 110.0           #Distância em que o inimigo irá começar a parar e trocar de state
var initial_player_position : Vector2
var is_stopping : bool = false

var player_direction : Vector2
var initial_player_direction : Vector2
func Enter():
	#Calcular a posição inicial do player e fazer o inimigo se mover até ela
	if is_instance_valid(_player):
		initial_player_position = _player.global_position
		_enemy.move_direction = (initial_player_position - _enemy.global_position)

func Phyisics_Update(_delta: float):
	Player_Pos()
	#Se o inimigo está parando, esperar sua velocidade chegar a 0 para trocar de state
	if is_stopping:
		#Quando velocidade chegar a zero, trocar de state
		if _enemy.velocity == Vector2.ZERO:
			Transitioned.emit(self, "attack")
		return
		
	if not is_instance_valid(_player):
		_enemy.move_direction = Vector2.ZERO
		is_stopping = true
		return
	
	#Se o inimigo estiver perto do player, ou de sua posição inicial quando começou a se aproximar, setar a direção para 0 para parar o movimento
	#Além disso, checa se está na tela para parar o movimento. Se faz isso para que o inimigo consiga pelo menos aparecer na tela antes de parar o movimento
	var is_at_stop_distance : bool = player_direction.length() <= stop_distance or initial_player_direction.length() <= stop_distance
	if is_at_stop_distance and _screen_notifier.is_on_screen():
		_enemy.move_direction = Vector2.ZERO
		is_stopping = true

func Player_Pos() -> void:
	if is_instance_valid(_player):
		player_direction = _player.global_position - _enemy.global_position     #Calcular a direção do player
		initial_player_direction = initial_player_position - _enemy.global_position #Calcular a direção do player na sua posição inicial (quando o inimigo entrou no state)
