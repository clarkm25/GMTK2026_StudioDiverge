extends CharacterBody2D

@export var move_speed = 100.0
@export var item_slot : Marker2D
@export var animation_player : AnimationPlayer
@onready var sprite = %Sprite2D

var current_item_stats : PickupStats
var idle_dir = Vector2.DOWN

func _ready():
	pass

func _physics_process(_delta):
	var direction = Input.get_vector("move_left","move_right","move_up", "move_down")
	if direction:
		velocity = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x,0,move_speed)
		velocity.y = move_toward(velocity.y,0,move_speed)
		
	move_and_slide()
	
	animation_player.speed_scale = velocity.length() / move_speed
	# Set an idle animation to prevent flickering from just setting a single frame
	if direction.x == 0 and direction.y == 0:
		if idle_dir == Vector2.DOWN:
			animation_player.play("idle_down")
		elif idle_dir == Vector2.UP:
			animation_player.play("idle_up")
		elif idle_dir == Vector2.LEFT:
			animation_player.play("idle_left")
			item_slot.scale.x = -1
		elif idle_dir == Vector2.RIGHT:
			animation_player.play("idle_right")
			item_slot.scale.x = 1
	if direction.x > 0:
		animation_player.play("walk_right")
		idle_dir = Vector2.RIGHT
		item_slot.scale.x = 1
	elif direction.x < 0:
		animation_player.play("walk_left")
		idle_dir = Vector2.LEFT
		item_slot.scale.x = -1
	elif direction.y < 0:
		animation_player.play("walk_up")
		idle_dir = Vector2.UP
	elif direction.y > 0:
		animation_player.play("walk_down")
		idle_dir = Vector2.DOWN
