extends Bullet
class_name PlayerBullet

func _ready():
	super()        #Chamar _ready() da classe pai para connectar os sinais
	speed = 1200
	damage = 1

func _physics_process(delta: float) -> void:
	position.y -= delta * speed
