extends Node

var music_player: AudioStreamPlayer

func _ready():
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	
	# Define o bus "music"
	music_player.bus = "Music"
	
	# Carrega e toca a música (substitua pelo caminho correto)
	music_player.stream = preload("uid://bi5oxradmdbh6")
	music_player.play()

func set_music_volume(db: float):
	music_player.volume_db = db

func pause_music():
	music_player.stream_paused = true

func unpause_music():
	music_player.stream_paused = false
