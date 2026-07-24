extends Node2D

var fade_timer = 1.5
@onready var fade_trans = $CanvasLayer/Control/FadeTransition
@onready var fade_anim = $CanvasLayer/Control/FadeTransition/AnimationPlayer
@onready var options = $CanvasLayer/Control/Options

func _ready() -> void:
	fade_trans.show()
	fade_anim.play('fade_in')


func _process(_delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	if fade_timer != null:
		fade_timer -= delta
		if fade_timer <= 0:
			fade_trans.queue_free()
			fade_timer = null
