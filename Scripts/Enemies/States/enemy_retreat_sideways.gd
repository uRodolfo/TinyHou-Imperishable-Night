extends State
class_name EnemyRetreatSideways

@export var stop_distance : float = 50.0

@onready var _enemy: EnemyFairy = owner
@onready var player_direction : Vector2

var _screen_middle_direction : Vector2

func Enter():
	#Conectar ao visible_on_screen_notifier para deletar o inimigo quando sair da tela
	var screen_notifier : VisibleOnScreenNotifier2D = _enemy.find_child("VisibleOnScreenNotifier2D")
	if screen_notifier:
		if not screen_notifier.is_connected("screen_exited", on_screen_exited):
			screen_notifier.connect("screen_exited", on_screen_exited)
	
	#Calcular a direção do meio da tela
		_screen_middle_direction = Vector2(128, _enemy.global_position.y) - _enemy.global_position
	
	#Diminuir a velocidade do inimigo para recuar mais devagar
	_enemy.speed /= 3
	_enemy.acceleration /= 5

func Phyisics_Update(_delta: float):
	#Fazer o inimigo se mover para a direção do meio da tela
	#O inimigo se move em direção ao meio a fim de dar mais tempo para o jogador matar o inimigo
	#Se o inimigo estiver exatamento no meio da tela, em vez disso ele irá se mover para a direita.
	if _screen_middle_direction != Vector2.ZERO:
		_enemy.move_direction = Vector2(_screen_middle_direction.x, 0)
	else:
		_enemy.move_direction = Vector2.RIGHT

func Exit():
	_enemy.speed = _enemy.MAX_SPEED
	_enemy.acceleration = _enemy.MAX_ACCELERATION

#Deletar inimigo quando sair da tela
func on_screen_exited():
	if _enemy:
		queue_free()
