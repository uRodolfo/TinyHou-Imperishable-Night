extends Node2D

@export_category("Circle_Spread")

@export_group("Pattern Propertys")
@export var number_of_bullets = 8
@export var spawn_radius = 0

@export_group("Bullets propertys")
@export var bullets_speed = 100
@export_enum("Purple", "Red") var bullets_color : String = "Purple"
@onready var rotation_per_bullet = (2 * PI) / number_of_bullets
var bullet = preload("res://Scenes/Enemy_Bullet.tscn")

func _ready() -> void:
	for i in range(number_of_bullets):
		var b = bullet.instantiate()
		var bullet_rotation = rotation_per_bullet * i - (PI/2)    #Calcular rotação das balas com base no número de balas
		var bullet_pos = (Vector2.RIGHT.rotated(bullet_rotation) * spawn_radius)    #Calcular posição das balas com base na sua rotação e spawn radius
		
		#Velocidade das balas
		b.speed = bullets_speed
		#Transforms
		b.global_position = self.position + bullet_pos
		b.rotation = self.rotation + bullet_rotation
		
		#Cor das balas
		var bullet_sprite = b.find_child("AnimatedSprite2D")
		if bullet_sprite:
			bullet_sprite.play(bullets_color)    #Alterar cor da bala
		
		get_tree().current_scene.add_child.call_deferred(b)
		queue_free()
