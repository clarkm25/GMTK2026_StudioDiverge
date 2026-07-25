extends Panel


@export var active = false
@export var in_main_menu = false

func _ready() -> void:
	if in_main_menu:
		$MarginContainer/VBoxContainer/HBoxContainer6.hide()


func _process(delta: float) -> void:
	if (Input.is_action_just_pressed('options')):
		if self.active:
			self.unpause()
		else:
			self.pause()


func pause():
	active = true
	self.show()
	get_tree().paused = true

func unpause():
	self.get_tree().paused = false
	hide()
	active = false


func _on_sound_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, value)

func _on_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, value)


func _on_mute_toggled(toggled_on: bool) -> void:
	if toggled_on:
		%Music.modulate = Color(0.273, 0.273, 0.273, 1.0)
		%Sound.modulate = Color(0.273, 0.273, 0.273, 1.0)
	else:
		%Music.modulate = Color(1.0, 1.0, 1.0, 1.0)
		%Sound.modulate = Color(1.0, 1.0, 1.0, 1.0)
	AudioServer.set_bus_mute(0, toggled_on)


func _on_reset_pressed() -> void:
	%Music.value = 0
	%Music.modulate = Color(1.0, 1.0, 1.0, 1.0)
	%Sound.value = 0
	%Sound.modulate = Color(1.0, 1.0, 1.0, 1.0)
	%Mute.button_pressed = false


func _on_close_pressed() -> void:
	unpause()


func _on_main_menu_pressed() -> void:
	unpause()
	get_tree().change_scene_to_file("res://menus/Menu.tscn")
