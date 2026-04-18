extends Area2D

var speed = 1600

func _physics_process(delta: float) -> void:
	position.y -= delta * speed
