extends State
class_name EnemyAttack

@onready var _bullet_pattern_gen : BulletPatternGenerator = owner.find_child("BulletPatternGenerator")

@export var attack_phase_duration_sec : float = 0.1

var phase_duration_counter_sec : float = 0.0

func Enter():
	phase_duration_counter_sec = attack_phase_duration_sec
	
	_bullet_pattern_gen.Enter()

func Update(_delta: float):
	if phase_duration_counter_sec > 0:
		phase_duration_counter_sec -= _delta
	else:
		Transitioned.emit(self, "retreat")

func Phyisics_Update(_delta: float):
	_bullet_pattern_gen.Emit_bullets(_delta)
