extends Node2D
class_name Enemy_bullet

var speed = 100  # Velocidade da bala
var direction = Vector2.ZERO  # Direção da bala

#Funções anônimas que podem ser passadas para a bala durante sua criação
var update_callback : Callable
var physicsUpdate_callback : Callable
var onReady_callback : Callable

#Métodos para setar as funções anônimas
func set_update_callback(cb: Callable):
	update_callback = cb
func set_physicsUpdate_callback(cb: Callable):
	physicsUpdate_callback = cb
func set_onReady_callback(cb: Callable):
	onReady_callback = cb

func _ready():
	$Area2D.body_entered.connect(_on_Area2D_body_entered)
	direction = Vector2.RIGHT.rotated(rotation)
	
	if onReady_callback:
		onReady_callback.call(self)

func _process(delta: float) -> void:
	if update_callback:
		update_callback.call(self, delta)

func _physics_process(delta: float) -> void:
	if physicsUpdate_callback:
		physicsUpdate_callback.call(self, delta)
	
	# Move a bala (Node2D)
	position += direction * speed * delta

func _on_Area2D_body_entered(body):
	print("Hit! Colidiu com:", body.name)
	queue_free()

#Deletar bala quando sair da tela
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
