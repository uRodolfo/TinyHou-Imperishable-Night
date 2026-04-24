extends CharacterBody2D

var speed = 300                  #Velocidade atual do jogador
@export var baseSpeed = 300      #Velocidade Base do jogador
@export var focusSpeedMultiplier = 0.5     #Multiplicador da velocidade Focus do jogador (Shift)

var canshoot = true              #True para poder atirar/Falso para não poder atirar

var Player_bullet = preload("res://Scenes/Playerbullet.tscn") # Bala do jogador

@onready var player_bullet_spawnpos = $Spawnpos # Posição aonde as balas do jogador surgem
@onready var _animated_sprite = $AnimatedSprite2D #Spritesheet animada do jogador

func _physics_process(delta):
	var direction = Vector2.ZERO

	# Movimentação
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

	velocity = direction.normalized() * speed
	var collision = move_and_collide(velocity * delta)

	# Verifica colisão
	if collision:
		var collider = collision.get_collider()
		if collider.name == "Enemy" or collider.name == "Bullet":
			print("Hit com:", collider.name)

func _process(delta):
	#Tiros do jogador
	if Input.is_action_pressed("Shoot") and canshoot:	#Detectar input para atirar balas
		shoot()
	
	#Animação do player
	
	#Animação Idle
	if velocity == Vector2.ZERO:
		_animated_sprite.play("Idle")
	else:
		#Animação esquerda e direita
		if velocity.x != 0:
			_animated_sprite.play("Moving_Left")
		
			#Flipar animação se for para a direita
			if velocity.x > 0:
				_animated_sprite.flip_h = true
			else:
				_animated_sprite.flip_h = false

#Timer para o jogador não conseguir spammar tiros além do limite
func _on_shootspeed_timeout():
	canshoot = true

#Método para spawnar as balas na posição do jogador
func shoot():
	var bullet = Player_bullet.instantiate() #Criar uma nova instância de player bullet e armazenar na variável local
	bullet.position = player_bullet_spawnpos.global_position #Setar a posição da instância como a mesma de spawnpos
	get_tree().current_scene.add_child(bullet) #Adcionar novo nó com a instância da bala do jogador
	
	$Shootspeed.start() #Iniciar timer Shootspeed
	canshoot = false #Fazer com que o jogador não possa atirar até o timer Shootspeed acabar
	
	
