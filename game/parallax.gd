extends Sprite2D

@export var layer = 1
@export var speed_offset = 0.1
@export var speed_multiplyer = 50

const size = Vector2(500, 3000)

func _physics_process(_delta: float) -> void:
	var dist_delta: float
	if Game.parallax_disabled:
		dist_delta = 10 * _delta
	else:
		dist_delta = Game.ship_speed * _delta
	
	var speed_variance = layer*speed_offset
	self.position.y += speed_variance * dist_delta * speed_multiplyer
	
	if self.position.y > size.y:
		self.position.y -= size.y * 2
