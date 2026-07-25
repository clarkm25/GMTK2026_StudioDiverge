extends Node2D

var fade_timer = 1.5
@export var fade_trans : FadeTransition
@onready var options = $CanvasLayer/Control/Options

func _ready() -> void:
	Game.music_player = %Music
	Game.cleanup_fade()
	await Game.fade_in()

var timer = 7.0
func _process(_delta: float) -> void:
	if timer == null: return
	timer -= _delta
	if timer <= 0:
		Game.swap_music()
		timer = null


func _physics_process(_delta: float) -> void:
	pass
