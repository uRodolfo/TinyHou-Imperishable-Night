extends Node2D

@onready var bullet_pattern = $BulletPatternGenerator

var wait_time := 0.015
var counter_time := 0.0

func _physics_process(delta: float) -> void:
	bullet_pattern.Emit_bullets(delta)

func _ready() -> void:
	bullet_pattern.Enter()
