extends Area2D
class_name Bullet

@export var screen_notifier : VisibleOnScreenNotifier2D

var speed := 100  # Velocidade da bala
var damage := 1
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

#Conectar sinais
func _ready() -> void:
	if not screen_notifier.screen_exited.is_connected(_on_visible_on_screen_notifier_2d_screen_exited):
		screen_notifier.screen_exited.connect(_on_visible_on_screen_notifier_2d_screen_exited)
		
	if not area_entered.is_connected(_on_hitbox_entered):
		area_entered.connect(_on_hitbox_entered)

func _on_hitbox_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		var hitbox : HitboxComponent = area
		hitbox.damage(self)

#Excluir balas quando sairem da tela
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
