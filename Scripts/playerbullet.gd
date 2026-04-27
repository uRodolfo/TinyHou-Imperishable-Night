extends Area2D
class_name PlayerBullet

@export var speed := 1600
@export var damage := 1

func _physics_process(delta: float) -> void:
	position.y -= delta * speed

#Deletar bala quando sair da tela
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_hitbox_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		var hitbox : HitboxComponent = area
		
		hitbox.damage(self)
