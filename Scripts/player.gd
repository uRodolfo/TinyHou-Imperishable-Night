extends CharacterBody2D

var speed = 300
var focusSpeed = 175

var canshoot = true

var Bullet = preload("res://Scenes/Bullet.tscn")

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
	var bullet = Bullet.instantiate()
