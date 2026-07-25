extends Sprite2D

@export var layer = 1
@export var speed_offset = 0.2
@onready var point_of_reference = $"../../Player" # TODO: swap player for spaceship

var pos_offset : Vector2
const size = Vector2i(3000, 500)

func _ready():
	pos_offset = self.position

func _process(_delta: float) -> void:
	self.position = (-point_of_reference.position*layer*speed_offset) + pos_offset
	if self.position.x - point_of_reference.position.x > size.x:
		pos_offset.x -= (size.x * 2)
	elif self.position.x - point_of_reference.position.x < -size.x:
		pos_offset.x += (size.x * 2)
