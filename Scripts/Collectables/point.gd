extends Area2D

var velocity = Vector2.ZERO
var _gravity = 100.0
var initial_up_impulse = -90.0  # Força inicial para subir

signal colided

func _ready():
	velocity.y = initial_up_impulse

func _physics_process(delta):
	# Aplica gravidade
	velocity.y += _gravity * delta
	position += velocity * delta

func _on_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("Player"):
		colided.emit()
		queue_free()
