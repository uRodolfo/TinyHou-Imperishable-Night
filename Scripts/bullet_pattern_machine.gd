extends Node2D

@onready var bullet_pattern : BulletPattern = $BP_Circle_Spread

var wait_time := 0.015
var counter_time := 0.0

func _ready() -> void:
	bullet_pattern.Enter()

func _physics_process(delta: float) -> void:
	bullet_pattern.PhysicsUpdate(delta)

func _process(delta: float) -> void:
	bullet_pattern.Update(delta)
