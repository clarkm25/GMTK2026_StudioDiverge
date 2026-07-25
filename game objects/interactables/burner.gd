extends Node2D

@export var sprite : Sprite2D
@export var item_slot : Marker2D

var burn_time : float
var accel_setting : float

func start_shine(time : float = 1.0):
	var tween = create_tween()
	tween.tween_method(set_shader_alpha, 0.0, 1.0, time)

func stop_shine(time : float = 1.0):
	var tween = create_tween()
	tween.tween_method(set_shader_alpha, 1.0, 0, time)

func set_shader_alpha(alpha_val):
	var source_color : Color = sprite.material.get_shader_parameter("line_color")
	sprite.material.set_shader_parameter("line_color", Color(source_color, alpha_val))

func _on_interactable_2d_closest(interactor):
	start_shine()
	
func _on_interactable_2d_not_closest(interactor):
	stop_shine()

func _on_interactable_2d_interacted(interactor):
	print("hi")
	var interactor_parent : CharacterBody2D = interactor.get_parent()
	if interactor_parent.name == "Player":
		# Activate ship burner
		var stats : PickupStats = interactor_parent.current_item_stats
		Game.ship_accel = stats.acceleration_given
		burn_time = stats.burn_time
		
		# Wipe player stat info
		interactor_parent.current_item_stats = null
		
		# Steal hat
		var player_item_slot : Marker2D = interactor_parent.item_slot
		var item_sprite : Node2D = player_item_slot.get_child(0)
		item_sprite.reparent(item_slot)
		item_sprite.position = Vector2.ZERO
		heat_up_sprite()
		
func _physics_process(delta):
	burn_time = clamp(burn_time - delta, 0, 100000000)
	if burn_time <= 0:
		Game.ship_accel = 0

func heat_up_sprite():
	var item_sprite = item_slot.get_child(0)
	var tween = get_tree().create_tween()
	tween.tween_property(item_slot, "modulate", Color(18.892, 3.504, 1.459), burn_time)
	tween.tween_property($CPUParticles2D, "emitting", true, 0)
	tween.tween_callback(item_sprite.queue_free)
		
