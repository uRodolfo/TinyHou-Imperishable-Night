extends HBoxContainer

func _process(delta: float) -> void:
	#Lógica para mostrar o número de estrelas de acordo com a vida do jogador
	var index = 0
	
	for child in get_children():
		if child is TextureRect:
			var pip : TextureRect = child
			if index < global_point_manager.player_bombs:    #Caso a vida seja suficiente, mostrar ícone
				pip.visible = true
			else:                                        #Caso a vida não seja suficiente, não mostrar
				pip.visible = false
			
			index += 1
