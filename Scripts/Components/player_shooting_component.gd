extends Node2D

var canshoot = true              #True para poder atirar/Falso para não poder atirar
var is_shooting = true           #Determina se o jogador está atirando ou não (toggle)

var Player_bullet = preload("res://Scenes/Playerbullet.tscn") # Bala do jogador

@onready var player_bullet_spawnpos = $Spawnpos # Posição aonde as balas do jogador surgem

#Timer para o jogador não conseguir spammar tiros além do limite
func _on_shootspeed_timeout():
	canshoot = true

#Método para spawnar as balas na posição do jogador
func shoot():
	var bullet = Player_bullet.instantiate() #Criar uma nova instância de player bullet e armazenar na variável local
	bullet.position = player_bullet_spawnpos.global_position #Setar a posição da instância como a mesma de spawnpos
	get_tree().current_scene.add_child(bullet) #Adcionar novo nó com a instância da bala do jogador
	
	$Shootspeed.start() #Iniciar timer Shootspeed
	canshoot = false #Fazer com que o jogador não possa atirar até o timer Shootspeed acabar

#Método para a mecânica de bomb
func bomb():
	var all_bullets = get_tree().get_nodes_in_group("Enemy_Bullets")
	for bullet in all_bullets:
		bullet.queue_free()
