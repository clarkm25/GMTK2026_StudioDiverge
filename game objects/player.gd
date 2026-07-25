extends CharacterBody2D

@export var move_speed = 100.0

@onready var sprite = $Sprite2D

var idle_dir = Vector2.DOWN

func _ready():
	pass
	#$AnimationPlayer.play("walk_down")
	#$AnimationPlayer.seek(0.9, true) # the standing pose of current animation

func _physics_process(_delta):
	var direction = Input.get_vector("move_left","move_right","move_up", "move_down")
	if direction:
		velocity = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x,0,move_speed)
		velocity.y = move_toward(velocity.y,0,move_speed)
		
	move_and_slide()
	
	# Set an idle animation to prevent flickering from just setting a single frame
	if direction.x == 0 and direction.y == 0:
		if idle_dir == Vector2.DOWN:
			$AnimationPlayer.play("idle_down")
		elif idle_dir == Vector2.UP:
			$AnimationPlayer.play("idle_up")
		elif idle_dir == Vector2.LEFT:
			$AnimationPlayer.play("idle_left")
		elif idle_dir == Vector2.RIGHT:
			$AnimationPlayer.play("idle_right")
	
	if direction.x > 0:
		$AnimationPlayer.play("walk_right")
		idle_dir = Vector2.RIGHT
	elif direction.x < 0:
		$AnimationPlayer.play("walk_left")
		idle_dir = Vector2.LEFT
	elif direction.y < 0:
		$AnimationPlayer.play("walk_up")
		idle_dir = Vector2.UP
	elif direction.y > 0:
		$AnimationPlayer.play("walk_down")
		idle_dir = Vector2.DOWN
