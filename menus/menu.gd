extends Node2D


var button_type = null


func _on_start_pressed() -> void:
	button_type = 'start'
	_fade_out()

func _on_options_pressed() -> void:
	button_type = 'options'
	_fade_out()

func _on_quit_pressed() -> void:
	button_type = 'quit'
	_fade_out()

func _fade_out() -> void:
	%FadeTransition.show()
	%FadeTransition/FadeTimer.start()
	%FadeTransition/AnimationPlayer.play('fade_out')

func _on_fade_timer_timeout() -> void:
	if button_type == 'start':
		get_tree().change_scene_to_file("res://game/Main.tscn")
	elif button_type == 'options':
		get_tree().change_scene_to_file("")
	elif button_type == 'quit':
		get_tree().quit()
