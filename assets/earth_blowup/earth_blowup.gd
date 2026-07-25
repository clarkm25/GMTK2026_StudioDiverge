extends AnimatedSprite2D

@onready var honey_label = %HoneyWeAreHome

@export var num_sec_fade := 1.5
func _ready():
	await Game.fade_in()
	var tween = create_tween()
	tween.tween_property(honey_label, "modulate:a", 2.5, num_sec_fade)
