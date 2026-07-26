extends Node2D

var objects_inside : Array[Node2D]

func _on_area_2d_area_entered(area : Area2D):
	if area.is_in_group("StairChecker"):
		var player = area.get_parent()
		objects_inside.append(player)
		
func _physics_process(delta):
	var player : CharacterBody2D
	if objects_inside.size() > 0:
		player = objects_inside[0]
		
	if !player:
		return
	
	if abs(player.velocity.x) > 0:
		player.position.y += -player.velocity.x * delta
		
func _on_area_2d_area_exited(area):
	if area.is_in_group("StairChecker"):
		var player = area.get_parent()
		objects_inside.erase(player)
