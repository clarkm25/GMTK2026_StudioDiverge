extends Node2D

var fade_timer = 1.5
@export var fade_trans : FadeTransition
@onready var options = $CanvasLayer/Control/Options

func _ready() -> void:
	Game.cleanup_fade()
	await Game.fade_in()


func _process(_delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	pass
