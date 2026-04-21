extends CharacterBody2D

var speed = 300
var focusSpeed = 175

var canshoot = true

var Player_bullet = preload("res://Scenes/Playerbullet.tscn") # Bala do jogador

@onready var player_bullet_spawnpos = $Spawnpos # Posição aonde as balas do jogador surgem

func _physics_process(delta):
	var direction = Vector2.ZERO

	# Movimentação
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	if Input.is_key_pressed(KEY_SHIFT):
		speed = focusSpeed
	else:
		speed = 300

	velocity = direction.normalized() * speed
	var collision = move_and_collide(velocity * delta)

	# Verifica colisão
	if collision:
		var collider = collision.get_collider()
		if collider.name == "Enemy" or collider.name == "Bullet":
			print("Hit com:", collider.name)
			


#Timer para o jogador não conseguir spammar tiros além do limite
func _on_shootspeed_timeout():
	canshoot = true

func _process(delta):
	if Input.is_action_pressed("Shoot") and canshoot:	#Detectar input para atirar balas
		shoot()

#Método para spawnar as balas na posição do jogador
func shoot():
	var bullet = Player_bullet.instantiate() #Criar uma nova instância de player bullet e armazenar na variável local
	bullet.position = player_bullet_spawnpos.global_position #Setar a posição da instância como a mesma de spawnpos
	get_tree().current_scene.add_child(bullet) #Adcionar novo nó com a instância da bala do jogador
	
	$Shootspeed.start() #Iniciar timer Shootspeed
	canshoot = false #Fazer com que o jogador não possa atirar até o timer Shootspeed acabar
	
	
