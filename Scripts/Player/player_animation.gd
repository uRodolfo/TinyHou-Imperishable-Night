extends Node2D

@onready var _player : Player = get_owner() #Jogador
@onready var _animated_sprite = $AnimatedSprite2D #Spritesheet animada do jogador

func _process(delta: float) -> void:
	#Animação do player
	
	#Animação Idle
	if _player.velocity == Vector2.ZERO:
		_animated_sprite.play("Idle")
	else:
		#Animação para cima
		if _player.velocity.y < 0:
			_animated_sprite.play("Idle") #Idle como placeholder!
			
		#Animação para baixo
		if _player.velocity.y > 0:
			_animated_sprite.play("Idle") #Idle como placeholder!
			
		#Animação esquerda e direita
		if _player.velocity.x != 0:
			_animated_sprite.play("Moving_Left")
		
			#Flipar animação se for para a direita
			if _player.velocity.x > 0:
				_animated_sprite.flip_h = true
			else:
				_animated_sprite.flip_h = false
