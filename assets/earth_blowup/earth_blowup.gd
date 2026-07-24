extends AnimatedSprite2D

@onready var honey_label = %HoneyWeAreHome

@export var num_sec_fade := 1.5
func _ready():
	var tween = create_tween()
	tween.tween_property(honey_label, "modulate:a", 1, num_sec_fade)
