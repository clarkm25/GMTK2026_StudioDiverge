extends Control

@export var ship: VSlider

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ship.max_value = Game.home_distance
	ship.value = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	ship.value = ship.max_value - Game.home_distance
