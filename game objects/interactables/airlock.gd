extends Node2D

@export var sprite : Sprite2D
@export var anim : AnimationPlayer
@export var item_slot : Marker2D
@export var audio_player : AudioStreamPlayer2D

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
	anim.queue('open')

func _on_interactable_2d_not_closest(interactor):
	stop_shine()
	anim.queue('close')

func _on_interactable_2d_interacted(interactor):
	print("eject")
	var interactor_parent : CharacterBody2D = interactor.get_parent()
	if interactor_parent.name != "Player": return
	
	# Eject
	var stats : PickupStats = interactor_parent.current_item_stats
	if stats == null: return
	Game.ship_mass -= stats.mass
	
	# Wipe player stat info
	interactor_parent.current_item_stats = null
	interactor_parent.droppable_item = false
	
	# Steal hat
	var player_item_slot : Marker2D = interactor_parent.item_slot
	var item_sprite : Node2D = player_item_slot.get_child(0)
	item_sprite.reparent(item_slot)
	item_sprite.position = Vector2.ZERO
	eject_sprite()

func eject_sprite():
	var item_sprite = item_slot.get_child(0)
	var tween = get_tree().create_tween()
	tween.tween_property(item_slot, "scale", Vector2.ZERO, 1)
	tween.tween_callback(item_sprite.queue_free)


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	audio_player.play()
