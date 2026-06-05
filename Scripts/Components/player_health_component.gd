#Variação de HealthComponent que aplica a lógica de tomar dano do player

extends HealthComponent

func damage(damage: float):
	super(damage)                   #Chamar o método da classe herdada
	
	global_point_manager.player_health = health
