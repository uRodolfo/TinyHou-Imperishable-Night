extends Node2D

var bullet_scene = load("res://Scenes/Bullet Patterns/BP_Circle_Spread.tscn")


@export_category("Rotating Pattern")
@export_group("Bullets Properties")
@export_enum("Purple", "Red") var bullets_color : String = "Purple"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	rotate(.2)

	var b = bullet_scene.instantiate()
	
	b.position = self.position
	b.rotation = self.rotation
	
	var bullet_sprite = b.find_child("AnimatedSprite2D")
	if bullet_sprite:
		bullet_sprite.play(bullets_color)    #Alterar cor da bala

	get_parent().add_child(b)
