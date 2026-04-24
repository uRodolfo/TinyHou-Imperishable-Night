extends Area2D

@export var speed = 1600

func _physics_process(delta: float) -> void:
	position.y -= delta * speed

#Deletar bala quando sair da tela
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
