extends Control

@onready var select: AudioStreamPlayer = $Select

func _ready() -> void:
	var start = $VBoxContainer/Start
	start.grab_focus()
	
	if not music_manager.music_player.playing:
		music_manager.music_player.play()

func _on_start_button_up() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
	music_manager.pause_music()

func _on_start_focus_entered() -> void:
	select.play()

func _on_quit_button_up() -> void:
	get_tree().quit()

func _on_quit_focus_entered() -> void:
	select.play()
