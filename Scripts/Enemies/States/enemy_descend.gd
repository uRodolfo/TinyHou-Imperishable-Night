extends State
class_name EnemyDescend

@onready var _enemy: EnemyFairy = owner

## Altura em que o inimigo irá parar de descer, de acordo com as coordenadas em Y
@export var Y_level_stop : float = 64

var is_stopping : bool = false

func Enter():
	_enemy.move_direction = Vector2.DOWN

func Phyisics_Update(_delta: float):
	if is_stopping:
		#Quando velocidade chegar a zero, trocar de state
		if _enemy.velocity == Vector2.ZERO:
			Transitioned.emit(self, "attack")
		return
	
	if _enemy.position.y >= Y_level_stop:
		_enemy.move_direction = Vector2.ZERO
		is_stopping = true
