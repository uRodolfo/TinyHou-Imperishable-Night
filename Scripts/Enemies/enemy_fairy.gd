extends CharacterBody2D
class_name EnemyFairy

@export var MAX_SPEED : float = 80.0
@export var MAX_ACCELERATION : float = 160.0

var speed : float
var acceleration : float
var move_direction : Vector2 = Vector2.ZERO

@onready var HealthComponent := $HealthComponent #Componente que faz a lógica de vida

func _ready() -> void:
	speed = MAX_SPEED
	acceleration = MAX_ACCELERATION

func _physics_process(delta: float) -> void:
	#Acelerar o inimigo caso tenha uma direção. Caso não tenha, desacelerar até que fique parado
	if move_direction != Vector2.ZERO:
		var max_velocity : Vector2 = move_direction.normalized() * speed
		velocity = velocity.move_toward(max_velocity, delta * acceleration)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, delta * acceleration)
		
	move_and_slide()
	
	if HealthComponent.health <= 0:
		_on_enemy_died()

func _on_hitbox_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		var hitbox : HitboxComponent = area
		hitbox.damage(1)
		

func _on_enemy_died():
	global_point_manager.spawn_point(position)
