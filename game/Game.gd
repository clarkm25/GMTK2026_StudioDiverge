extends Node2D

var ship_speed : float
var ship_accel : float
## Percentage, represented as 0-1 decimal (i.e., 0.7777=77.77%)
var ship_integrity : float:
	get():
		return ship_integrity
	set(value):
		ship_integrity = clamp(value, 0, 1)

var home_distance : float
var ship_home : bool = false

@export_category("Starting Configuration")
@export var starting_distance : int
@export var starting_velocity : float

var fade_transition = preload("res://menus/FadeTransition.tscn")

var music_player : AudioStreamPlayer

func _ready():
	process_mode = ProcessMode.PROCESS_MODE_ALWAYS

func _process(_delta):
	pass

func _physics_process(delta):
	ship_speed += ship_accel*delta
	home_distance = clamp(home_distance - (ship_speed * delta), -1, 1000000000000)
	if home_distance <= -1 and !ship_home:
		ship_home = true
		await fade_out()
		# Change scene to destruction scene
		get_tree().change_scene_to_file("res://menus/earth_blowup.tscn")

func change_audio_bus_volume(value: float):
	var index = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(index, value)

func swap_music():
	var tween = get_tree().create_tween()
	tween.tween_method(change_audio_bus_volume, 0.0, -60.0, 2.0)
	var collapse_of_the_core = AudioStreamOggVorbis.load_from_file("res://assets/sfx/collapse_of_the_core.ogg")
	tween.tween_callback(swap_audio.bind(collapse_of_the_core))
	tween.tween_method(change_audio_bus_volume, -60.0, 0.0, 2.0)

func swap_audio(music_resource : AudioStreamOggVorbis):
	print(music_resource)
	music_player.stream = music_resource
	music_player.play()

func fade_in():
	var tween = get_tree().create_tween()
	tween.tween_method(change_audio_bus_volume, -60.0, 0.0, 3.0)
	
	var canvas_layer := CanvasLayer.new()
	canvas_layer.add_to_group("FadeLayer")
	add_child(canvas_layer)
	
	var fade_instance : FadeTransition = fade_transition.instantiate()
	canvas_layer.add_child(fade_instance)
	
	await fade_instance.fade_in()

func fade_out():
	var tween = get_tree().create_tween()
	tween.tween_method(change_audio_bus_volume, 0.0, -60.0, 1.5)
	
	var canvas_layer := CanvasLayer.new()
	canvas_layer.add_to_group("FadeLayer")
	add_child(canvas_layer)
	
	var fade_instance : FadeTransition = fade_transition.instantiate()
	canvas_layer.add_child(fade_instance)
	
	await fade_instance.fade_out()

func cleanup_fade():
	var children = get_tree().get_nodes_in_group("FadeLayer")
	for child in children:
		child.queue_free()
