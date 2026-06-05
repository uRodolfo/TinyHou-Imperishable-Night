extends Control

@onready var line_edit_name = $Type
@onready var label_score = $ScorePoints
@onready var button_save = $Button

var current_score: float = 0

func _ready():
	current_score = global_point_manager.points  
	label_score.text = str(current_score)
	call_deferred("set_foco")  # espera um frame

func set_foco():
	line_edit_name.grab_focus()

func _on_button_pressed():
	var player_name = line_edit_name.text.strip_edges()
	if player_name == "":
		# Permite anônimo, mas agora o jogador pode digitar nomes diferentes
		player_name = "cacadora anonima"
	print("Salvando: ", player_name, " - ", current_score)
	save_manager.add_or_update_score(player_name, current_score)
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
