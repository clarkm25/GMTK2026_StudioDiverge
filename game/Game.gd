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

func _ready():
	process_mode = ProcessMode.PROCESS_MODE_ALWAYS
	
func _process(delta):
	pass
	
func _physics_process(delta):
	ship_speed += ship_accel*delta
	home_distance = clamp(home_distance - (ship_speed * delta), -1, 1000000000000)
	if home_distance <= -1 and !ship_home:
		ship_home = true
		await fade_out()
		# Change scene to destruction scene
		get_tree().change_scene_to_file("res://assets/earth_blowup/earth_blowup.tscn")

func fade_in():
	var canvas_layer := CanvasLayer.new()
	canvas_layer.add_to_group("FadeLayer")
	add_child(canvas_layer)
	
	var fade_instance : FadeTransition = fade_transition.instantiate()
	canvas_layer.add_child(fade_instance)
	
	await fade_instance.fade_in()
	
func fade_out():
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
