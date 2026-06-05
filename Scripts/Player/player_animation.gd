extends Node2D

@onready var _player : Player = get_owner() #Jogador
@onready var _animated_sprite : AnimatedSprite2D = $AnimatedSprite2D #Spritesheet animada do jogador

func _process(delta: float) -> void:
	#Animação do player
	
	#Animação Idle
	if _player.velocity == Vector2.ZERO:
		_animated_sprite.play("Idle")
		_animated_sprite.flip_h = false
	else:
		#Animação para cima
		if _player.velocity.y < 0 and _player.velocity.x == 0:
			_animated_sprite.play("Idle") #Idle como placeholder!
			
		#Animação para baixo
		if _player.velocity.y > 0 and _player.velocity.x == 0:
			_animated_sprite.play("Idle") #Idle como placeholder!
			
		#Animação para direita
		if _player.velocity.x > 0:
			if _animated_sprite.animation != "Moving_Left_Loop" or _animated_sprite.flip_h == false:
				_animated_sprite.play("Moving_Left_Startup")
			#Flipar animação de acordo com o lado
			_animated_sprite.flip_h = true
		
		#Animação para esquerda
		if _player.velocity.x < 0:
			if _animated_sprite.animation != "Moving_Left_Loop" or _animated_sprite.flip_h == true:
				_animated_sprite.play("Moving_Left_Startup")
			#Flipar animação de acordo com o lado
			_animated_sprite.flip_h = false

func _on_animated_sprite_2d_animation_finished() -> void:
	if _animated_sprite.animation == "Moving_Left_Startup":
		_animated_sprite.play("Moving_Left_Loop")
