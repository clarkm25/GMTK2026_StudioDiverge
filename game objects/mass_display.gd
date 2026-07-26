extends Node2D

@export var cargo_mass : Label

func _ready():
	Game.mass_updated.connect(_update_screen)
	_update_screen()
	
func _update_screen():
	cargo_mass.text = "%d gg" % Game.ship_mass
