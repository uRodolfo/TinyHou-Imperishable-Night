extends CharacterBody2D

var speed = 300
var focusSpeed = 175

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
