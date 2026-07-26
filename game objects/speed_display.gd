extends Node2D

@export var speed : Label

func _ready():
	Game.mass_updated.connect(_update_screen)
	_update_screen()
	
func _update_screen():
	speed.text = "%d gn/s" % Game.ship_speed
