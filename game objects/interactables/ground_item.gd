extends Node2D

@export var sprite : Sprite2D
@export var head_sprite : PackedScene
@export var item_stats : PickupStats

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

func deactivate_interactable(interactor):
	$Interactable2D.set_deferred("monitoring", false)
	$Interactable2D.set_deferred("monitorable", false)
	$Interactable2D.not_closest.emit(interactor)
	stop_shine(0.0)
	
func deactivate_staticbody():
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)


func _on_interactable_2d_interacted(interactor : Interactor2D):
	print("hi")
	var interactor_parent = interactor.get_parent()
	if interactor_parent.name == "Player":
		if interactor_parent.droppable_item:
			interactor_parent.drop_item()
		
		var top_head := head_sprite.instantiate()
		
		interactor_parent.item_slot.add_child(top_head)
		interactor_parent.current_item_stats = item_stats
		interactor_parent.droppable_item = true
		queue_free()
