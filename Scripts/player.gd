extends CharacterBody2D
class_name Player

#Player Attributes
var speed = 300                  #Velocidade atual do jogador
@export var baseSpeed = 300      #Velocidade Base do jogador
@export var focusSpeedMultiplier = 0.5     #Multiplicador da velocidade Focus do jogador (Shift)
var direction = Vector2.ZERO

var shoot_key_press_count = 0    #Conta quantas vezes o botão de tiro foi apertado dentro de 0.5s

#Nodes
@onready var _player_shooting = $Player_Shooting #Lógica de tiros do jogador
@onready var _bomb_double_tap_interval = $Bomb_double_tap_interval #Tempo entre os dois cliques de tiro para ativar o bomb


func _physics_process(delta):
	

	velocity = direction.normalized() * speed
	var collision = move_and_collide(velocity * delta)

	# Verifica colisão
	if collision:
		var collider = collision.get_collider()
		if collider.name == "Enemy" or collider.name == "Bullet":
			print("Hit com:", collider.name)

func _process(delta):
	# Movimentação
	direction = Vector2.ZERO
	
	if Input.is_action_pressed("Move_Right"):
		direction.x += 1
	if Input.is_action_pressed("Move_Left"):
		direction.x -= 1
	if Input.is_action_pressed("Move_Down"):
		direction.y += 1
	if Input.is_action_pressed("Move_Up"):
		direction.y -= 1

	if Input.is_action_pressed("Focus"):
		speed = baseSpeed * focusSpeedMultiplier
	else:
		speed = baseSpeed
	
	#Tiros do jogador
	if Input.is_action_pressed("Shoot") and _player_shooting.canshoot:	#Detectar input para atirar balas
		#Atirar
		_player_shooting.shoot()
	
	#Ativar bomb se apertar 2 vezes entre 0.5 segundos
	if Input.is_action_just_pressed("Shoot"):
		_bomb_double_tap_interval.start()
		if shoot_key_press_count == 1:
			_player_shooting.bomb()
			shoot_key_press_count = 0
		else:
			shoot_key_press_count += 1

#Resetar quantas vezes foi apertado para 0 depois do intervalo de tempo
func _on_bomb_double_tap_interval_timeout() -> void:
	shoot_key_press_count = 0
