extends Node2D

var speed = 150  # Velocidade da bala
var direction = Vector2.ZERO  # Direção da bala

func _ready():
	$Area2D.body_entered.connect(_on_Area2D_body_entered)

	direction = Vector2.RIGHT.rotated(rotation)

func _process(delta):
	# Move a bala (Node2D)
	position += direction * speed * delta

	# Move a hitbox (Area2D) junto com o Node2D
	$Area2D.position = Vector2.ZERO  # Garante que siga o Node2D centralmente

func _on_Area2D_body_entered(body):
	print("Hit! Colidiu com:", body.name)
	queue_free()
