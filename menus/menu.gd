extends Control


var button_type = null

@onready var options = $Options
@onready var fade_trans = $FadeTransition
@onready var fade_anim = $FadeTransition/AnimationPlayer


func _on_start_pressed() -> void:
	button_type = 'start'
	_fade_out()

func _on_options_pressed() -> void:
	options.pause()

func _on_quit_pressed() -> void:
	button_type = 'quit'
	_fade_out()

func _fade_out() -> void:
	await Game.fade_out()
	match button_type:
		'start':
			get_tree().change_scene_to_file("res://game/Main.tscn")
		'quit':
			get_tree().quit()
