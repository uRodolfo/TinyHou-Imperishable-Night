extends CanvasLayer  # ou Node2D, dependendo da sua UI

@onready var points_label = $PointsLabel  # caminho do seu Label

func _ready():
	global_point_manager.points_updated.connect(_on_points_updated)
	_on_points_updated(global_point_manager.points)  # inicializa o texto

func _on_points_updated(new_points):
	points_label.text = str(new_points)  # converte para string
