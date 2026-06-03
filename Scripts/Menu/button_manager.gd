extends Control

@onready var select: AudioStreamPlayer = $SeSelect00

func _ready() -> void:
	var start = $VBoxContainer/Start
	start.grab_focus()

func _on_start_button_up() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
	pass # Replace with function body.
	

func _on_start_focus_entered() -> void:
	select.play()
	pass # Replace with function body.


func _on_quit_button_up() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_quit_focus_entered() -> void:
	select.play()
	pass # Replace with function body.
