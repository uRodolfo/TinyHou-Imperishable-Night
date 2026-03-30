extends Node2D

var bullet_scene = load("res://Scenes/Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate(.2)

	var b = bullet_scene.instantiate()
	b.position = self.position
	b.rotation = self.rotation

	get_parent().add_child(b)
