extends Node2D

var bullet_scene = load("res://Scenes/Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	rotate(.2)

	var b = bullet_scene.instantiate()
	
	var bullet_sprite = b.find_child("AnimatedSprite2D")
	
	b.position = self.position
	b.rotation = self.rotation
	
	bullet_sprite.play("Purple")    #Alterar cor da bala

	get_parent().add_child(b)
