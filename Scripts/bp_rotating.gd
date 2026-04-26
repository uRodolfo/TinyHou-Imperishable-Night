extends Node2D

var bullet_scene = load("res://Scenes/Enemy_Bullet.tscn")


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
	
	#Testando o uso de funções anônimas para serem enviadas às balas
	var state := {"rotation":0}    #Usa-se um dicionário para ser passado como referência, e não como um valor
	b.set_physicsUpdate_callback(func(caller, delta):
		state.rotation = fmod(state.rotation + 4, 360)
		var bullet_size = abs(cos(deg_to_rad(state.rotation))) + 0.75

		caller.scale = Vector2(bullet_size, bullet_size)
	)
		
	var bullet_sprite = b.find_child("AnimatedSprite2D")
	if bullet_sprite:
		bullet_sprite.play(bullets_color)    #Alterar cor da bala

	get_parent().add_child(b)
