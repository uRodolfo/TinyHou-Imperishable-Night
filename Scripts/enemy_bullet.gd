extends Bullet
class_name Enemy_bullet

func _ready():
	super()        #Chamar _ready() da classe pai para connectar os sinais
	direction = Vector2.RIGHT.rotated(rotation)
	
	if onReady_callback and onReady_callback.is_valid():
		onReady_callback.call(self)

func _process(delta: float) -> void:
	if update_callback and update_callback.is_valid():
		update_callback.call(self, delta)

func _physics_process(delta: float) -> void:
	if physicsUpdate_callback and physicsUpdate_callback.is_valid():
		physicsUpdate_callback.call(self, delta)
	
	# Move a bala (Node2D)
	position += direction * speed * delta
