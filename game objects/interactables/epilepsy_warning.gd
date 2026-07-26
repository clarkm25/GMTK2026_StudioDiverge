extends Node2D

var timer = 8.0

func _ready():
	Game.cleanup_fade()
	await Game.fade_in()

func _fade_out() -> void:
	await Game.fade_out()
	get_tree().change_scene_to_file("res://game/Main.tscn")

func _process(delta: float) -> void:
	if timer == null: return
	timer -= delta
	if timer <= 0:
		Game.cleanup_fade()
		_fade_out()
		timer = null
