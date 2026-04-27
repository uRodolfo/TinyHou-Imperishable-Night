extends Node2D
class_name BulletBuildComponent

@export var bullet_scene = preload("res://Scenes/Enemy_Bullet.tscn")

@export_group("Bullets propertys")
@export var bullet_speed = 100
@export_enum("Purple", "Red") var bullets_color : String = "Purple"

func build_bullet() -> Enemy_bullet:
	if bullet_scene.instantiate() is not Enemy_bullet:
		return
	
	var b : Enemy_bullet = bullet_scene.instantiate()
	if get_parent() is Node2D:
		var parent : Node2D = get_parent()
			
		b.global_position = parent.position
		b.rotation = parent.rotation
		b.speed = bullet_speed
		
		#Cor das balas
		var bullet_sprite = b.find_child("AnimatedSprite2D")
		if bullet_sprite:
			bullet_sprite.play(bullets_color)   #Alterar cor da bala
			
	return b
	
