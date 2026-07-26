extends CharacterBody2D

@export var move_speed = 100.0
@export var item_slot : Marker2D
@export var animation_player : AnimationPlayer
@export var raycast : RayCast2D
@onready var sprite = %Sprite2D

var current_item_stats : PickupStats
var idle_dir = Vector2.DOWN
var drop_distance = 30
var droppable_item = false

@export var interaction_area : Area2D

func _ready():
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('interact'):
		if current_item_stats == null: 
			print("Null item stats")
			return
		
		get_viewport().set_input_as_handled()
		
		drop_item()

func drop_item():
	var item_scene = load(current_item_stats.scene_path)
	var item_instance = item_scene.instantiate()
	var location
	
	if raycast.is_colliding():
		location = raycast.get_collision_point()
	else:
		location = self.position + raycast.target_position
	
	item_instance.position = location
	item_instance.item_stats = current_item_stats
		
	var held_item = item_slot.get_child(0)
	held_item.queue_free()
	current_item_stats = null
	
	droppable_item = false
	
	get_tree().current_scene.add_child(item_instance)

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

	raycast.target_position = idle_dir * drop_distance
