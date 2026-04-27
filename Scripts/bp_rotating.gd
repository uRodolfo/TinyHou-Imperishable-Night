extends Node2D

@export var bullet_build_component : BulletBuildComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	rotate(.2)

	var b = bullet_build_component.build_bullet()
	
	#Testando o uso de funções anônimas para serem enviadas às balas
	var state := {"rotation":0, "basespeed":0}    #Usa-se um dicionário para ser passado como referência, e não como um valor
	b.set_physicsUpdate_callback(func(caller, delta):
		state.rotation = fmod(state.rotation + 4, 360)
		
		var bullet_size = abs(cos(deg_to_rad(state.rotation))) + 0.75
		var bullet_speed_multiplier = abs(sin(deg_to_rad(state.rotation)))
		
		caller.speed = state.basespeed * bullet_speed_multiplier
		
		caller.scale = Vector2(bullet_size, bullet_size)
	)
	
	b.set_onReady_callback(func(caller):
		state.basespeed = caller.speed
	)

	get_parent().add_child(b)
