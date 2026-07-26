extends Node2D

@export var options : Panel

func _ready() -> void:
	Game.music_player = %Music
	Game.cleanup_fade()
	await Game.fade_in()

# TODO: convert timer to distance (half way to earth)
var timer = 7.0
func _process(_delta: float) -> void:
	if timer == null: return
	timer -= _delta
	if timer <= 0:
		Game.swap_music()
		timer = null


func _physics_process(_delta: float) -> void:
	pass
