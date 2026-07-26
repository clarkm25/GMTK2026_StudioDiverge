extends Node2D

@export var options : Panel

func _ready() -> void:
	Game.reset()
	Game.music_player = %Music
	Game.cleanup_fade()
	await Game.fade_in()
