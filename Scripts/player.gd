extends CharacterBody2D
class_name Player

#Player Attributes
var speed = 300                  #Velocidade atual do jogador
@export var baseSpeed = 80      #Velocidade Base do jogador
@export var focusSpeed = 40     #Velocidade Focus do jogador (Shift)
var direction = Vector2.ZERO

#Nodes
@onready var _player_shooting = $Player_Shooting #Lógica de tiros do jogador
@onready var _shoot_key_interval = $Shoot_key_interval #Tempo para segurar o botão para alternar o modo de tiro


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
		speed = focusSpeed
	else:
		speed = baseSpeed
	
	if _player_shooting.is_shooting and _player_shooting.canshoot:
		_player_shooting.shoot()
	
	#Ativar bomb se apertar 2 vezes entre 0.5 segundos
	if Input.is_action_just_pressed("Shoot"):
		_shoot_key_interval.start()
	else: if Input.is_action_just_released("Shoot") and _shoot_key_interval.time_left > 0.1:
		_player_shooting.bomb()
	
func _on_shoot_key_interval_timeout() -> void:
	#Tiros do jogador
	if Input.is_action_pressed("Shoot"):
		_player_shooting.is_shooting = !_player_shooting.is_shooting
