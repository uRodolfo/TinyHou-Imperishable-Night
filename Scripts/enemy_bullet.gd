extends Node2D

var speed = 100  # Velocidade da bala
var direction = Vector2.ZERO  # Direção da bala

func _ready():
	$Area2D.body_entered.connect(_on_Area2D_body_entered)

	direction = Vector2.RIGHT.rotated(rotation)

func _physics_process(delta: float) -> void:
	# Move a bala (Node2D)
	position += direction * speed * delta

func _on_Area2D_body_entered(body):
	print("Hit! Colidiu com:", body.name)
	queue_free()

#Deletar bala quando sair da tela
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
