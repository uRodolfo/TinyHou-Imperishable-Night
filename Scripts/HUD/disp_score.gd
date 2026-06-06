extends Label

func _ready():
	global_point_manager.points = 0

func _process(delta):
	text = str(global_point_manager.points)
