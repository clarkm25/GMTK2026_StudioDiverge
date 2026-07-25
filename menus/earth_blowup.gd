extends AnimatedSprite2D

@onready var honey_label = %HoneyWeAreHome

@export var num_sec_fade := 1.5

var timer = 4.3

func _ready():
	Game.cleanup_fade()
	await Game.fade_in()
	var tween = create_tween()
	tween.tween_property(honey_label, "modulate:a", 2.5, num_sec_fade)

func _process(delta: float) -> void:
	if timer == null: return
	timer -= delta
	if  timer <= 0:
		$"../Music".stop()
		$"../SFX".play()
		timer = null

func _on_animation_finished() -> void:
	Game.cleanup_fade()
	await Game.fade_out()
	get_tree().change_scene_to_file("res://menus/Menu.tscn")
