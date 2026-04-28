extends Resource
class_name BulletPatternRes

@export_category("Pattern Properties")
@export var number_of_bullets := 1
@export var bullets_speed := 100
@export var spawn_radius := 0.0
@export var rotation_speed := 0.0
@export var initial_rotation := 0.0
@export var seconds_between_shots := 1.0
@export var spread_angle_deg = 0.0

@export_category("Controls")
@export var is_spread_radial = false
@export_enum("None", "Pattern to Player", "Bullet to Player") var bullets_direction : String = "None"
