extends Sprite2D

@export var layer = 1
@export var speed_offset = 0.2
@onready var point_of_reference = $"../../Player" # TODO: swap player for spaceship

const size = Vector2(500, 3000)

func _physics_process(_delta: float) -> void:
	
	var dist = Game.home_distance
	var speed_variance = layer*speed_offset
	var dist_delta = clamp(Game.ship_speed * _delta, -1, 1000000000000)
	self.position.y += speed_variance * dist_delta
	
	if self.position.y > size.y:
		self.position.y -= size.y * 2
