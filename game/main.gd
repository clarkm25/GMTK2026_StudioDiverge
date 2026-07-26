extends Node2D

@export var options : Panel

func _ready() -> void:
	Game.reset()
	Game.music_player = %Music
	Game.cleanup_fade()
	await Game.fade_in()
	
	var mass_sum := 1.0
	var all_pickups = get_tree().get_nodes_in_group("GroundItem")
	for pickup in all_pickups:
		if pickup.item_stats:
			mass_sum += pickup.item_stats.mass
	Game.ship_mass = mass_sum
	
