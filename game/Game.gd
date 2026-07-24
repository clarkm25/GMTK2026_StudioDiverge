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

@export_category("Starting Configuration")
@export var starting_distance : int
@export var starting_velocity : float

func _ready():
	pass
	
func _process(delta):
	pass
	
func _physics_process(delta):
	ship_speed += ship_accel*delta
	home_distance = clamp(home_distance - (ship_speed * delta), -1, 1000000000000)
	if home_distance <= -1:
		get_tree().change_scene_to_file("res://assets/earth_blowup/earth_blowup.tscn")
